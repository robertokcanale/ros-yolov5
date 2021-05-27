import numpy as np
import argparse
import torch
import cv2
import random
from operator import add 
import time
import math
import rospy
from visualization_msgs.msg import MarkerArray
from visualization_msgs.msg import Marker
from geometry_msgs.msg import Point
from std_msgs.msg import ColorRGBA
from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, \
    scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized
#For Raw Detections
class BoundingBox:
    label = ""
    confidence = 0.0
    coordinates = np.zeros(4, dtype=np.float32)
    id = 0
    def __init__(self):
        pass
    def set_bb(self, id, label, confidence, coordinates):
        self.id = id
        self.label = label
        self.confidence = confidence
        self.coordinates = coordinates

#For Reshaped Detections
class BoundingBoxReshaped:
    label = ""
    confidence = 0.0
    coordinates_reshaped = np.zeros(4, dtype=np.int32)
    id = 0
    def __init__(self):
        pass
    def set_bb(self, id, label, confidence, coordinates_reshaped):
        self.id = id
        self.label = label
        self.confidence = confidence
        self.coordinates_reshaped = coordinates_reshaped

#Reshape bb coordinates for images of different size
def reshape_coordinates_bb (coord_in, width_i, height_i, width_o, height_o):
    coord_out = np.zeros(len(coord_in), dtype= np.int32)
    for i in range(len(coord_in)):
        coord_out[0] = (coord_in[0]*width_o/width_i) #int(max(float(0), (coord_in[0]*width_o/width_i)))  #x1
        coord_out[1] = (coord_in[1]*height_o/height_i) #int(max(float(0), (coord_in[1]*height_o/height_i)))   #y1
        coord_out[2] = (coord_in[2]*width_o/width_i) #int(max(float(0), (coord_in[2]*width_o/width_i))) #x2
        coord_out[3] = (coord_in[3]*height_o/height_i)#int(max(float(0), (coord_in[3]*height_o/height_i))) #y
    return coord_out

#Create a Bounding Box object with the predictions
def bounding_box_predictions(det, bb_number, names):
    bb_predictions = [BoundingBox() for i in range(bb_number)]
    for i in range(bb_number): #scan the prediction matrix DET/PRED (they are the same)
        coordinates=[round(det[i][0].item(),3),round(det[i][1].item(),3),round(det[i][2].item(),3),round(det[i][3].item(),3)] 
        confidence = round(det[i][4].item(),5)
        obj_class_id = int(det[i][5].item())
        obj_class = names[int(det[i][5].item())]
        bb_predictions[i].set_bb(obj_class_id, obj_class, confidence, coordinates)
    return bb_predictions

#Create a Reshaped Bounding Box object with the predictions and image
def bounding_box_predictions_reshaped(bb_predictions, bb_number, I_backtorgb, colors, rows, cols):
    bb_predictions_reshaped = [BoundingBoxReshaped() for i in range(bb_number)]
    for i in range(bb_number): 
        xyxy = reshape_coordinates_bb(bb_predictions[i].coordinates, 416, 416, cols, rows) #for a different image size
        bb_predictions_reshaped[i].set_bb(bb_predictions[i].id, bb_predictions[i].label, bb_predictions[i].confidence, xyxy)

    for i in range(bb_number):  #reshaped detections on image
            label = str(bb_predictions_reshaped[i].label) + " " + str(round(bb_predictions_reshaped[i].confidence, 2))
            plot_one_box(bb_predictions_reshaped[i].coordinates_reshaped, I_backtorgb, label=label, color=colors[bb_predictions[i].id], line_thickness=1) 

    return bb_predictions_reshaped, I_backtorgb

#Get list of active taxels per bounding box on the image, create an array of the taxel center
def bb_active_taxel (bb_number, T, bb_predictions_reshaped, TIB, skin_faces):
    taxel_predictions = np.empty((bb_number,), dtype = object)
    pixel_positions = np.empty((bb_number,), dtype = object)
    taxel_predictions_info = np.empty((bb_number,), dtype = object)
    for n in range(bb_number):
        faces_predictions = []
        pixel_position = []
        info = []
        for i in range(bb_predictions_reshaped[n].coordinates_reshaped[0], bb_predictions_reshaped[n].coordinates_reshaped[2]):
            for j in range(bb_predictions_reshaped[n].coordinates_reshaped[1], bb_predictions_reshaped[n].coordinates_reshaped[3]):
                face_index = TIB.get_pixel_face_index( i,  j)
                if face_index == (-1) or face_index >= 1218: #checking that taxels are withing boundss
                    break
                #Pixel_Position
                pos_on_map = TIB.get_pixel_position_on_map(i, j)
                pixel_pos = T.back_project_point(pos_on_map, face_index)
                pixel_position.append(pixel_pos)  

                #Taxel_IDs_from_faces
                faces_predictions.append(skin_faces[face_index][0])
                faces_predictions.append(skin_faces[face_index][1])
                faces_predictions.append(skin_faces[face_index][2])

            taxel_predictions[n] = set(faces_predictions) #set rmoves duplicates
            pixel_positions[n] = pixel_position

        #Prediction info
        info.append(bb_predictions_reshaped[n].label)
        info.append(bb_predictions_reshaped[n].confidence)
        info.append(len(set(faces_predictions)))
        taxel_predictions_info[n] = info #this is the name, conf and # active taxels per prediction
    return taxel_predictions, pixel_positions, taxel_predictions_info

#Get taxel responses for all bounding boxes 
def get_taxel_data(bb_number, S, T, taxel_predictions, taxel_predictions_info, number_of_ids):
    total_taxel_responses = np.empty((bb_number,), dtype = object)
    total_taxels_position = np.empty((bb_number,), dtype = object)
    total_taxels_2D_position = np.empty((bb_number,), dtype = object)
    total_taxel_normals = np.empty((bb_number,), dtype = object)
    average_responses = np.empty((bb_number,), dtype = object)
    bb_centroid = np.empty((bb_number,), dtype = object)
    bb_centroid2d = np.empty((bb_number,), dtype = object)
    bb_normal = np.empty((bb_number,), dtype = object)
    #TOTAL RESPONSES
    for n in range(bb_number):
        taxel_response = [] #empty array for the responses of a single bounding box
        taxels_position = [] #empty array for the idus of a single bounding box
        taxels_2d_position = [] #empty array for the idus of a single bounding box
        taxel_normal = [] #empty array for the normals single bounding box
        for i in taxel_predictions[n]:
            if S.taxels[i].get_taxel_response() != 0: 
                taxel_response.append(S.taxels[i].get_taxel_response()) 
                taxels_position.append(S.taxels[i].get_taxel_position()) 
                taxel_normal.append(S.taxels[i].get_taxel_normal()) 
                taxels_2d_position.append(T.taxels[i].get_taxel_position()) #on the tactile map

        if taxel_response == [] or taxels_position == []:
            total_taxel_responses[n] = []
            total_taxels_position[n] = []
            total_taxels_2D_position[n] = []
            total_taxel_normals[n] = []
        else: 
            total_taxel_responses[n] = taxel_response
            total_taxels_position[n] = taxels_position
            total_taxel_normals[n] = taxel_normal
            total_taxels_2D_position[n] = taxels_2d_position
    
    #AVERAGE RESPONSES including taxels with 0 response
    for n in range(bb_number):
        if len(total_taxels_position[n]) != 0:
            average_response = sum(total_taxel_responses[n])/taxel_predictions_info[n][2]
            average_responses[n] = average_response
            print("Average Response of", taxel_predictions_info[n][0], "is", average_responses[n])
        else:
            average_responses[n] = 0.0
    
    #AVERAGE POSITION 2D AND 3D CENTROID
    for n in range(bb_number):
        average_position = [0.0,0.0,0.0]
        if len(total_taxels_2D_position[n]) != 0:
            for i in range(len(total_taxels_2D_position[n])):
                average_position[0] = average_position[0] + total_taxels_2D_position[n][i][0]
                average_position[1] = average_position[1] + total_taxels_2D_position[n][i][1]
                average_position[2] = average_position[2] + total_taxels_2D_position[n][i][2] #z should be 0 anyway
            average_position[0] = average_position[0] / len(total_taxels_2D_position[n])
            average_position[1] = average_position[1] / len(total_taxels_2D_position[n])
            average_position[2] = average_position[2] / len(total_taxels_2D_position[n])

            bb_centroid2d[n]=average_position
            #used for projecting a 2D centroid on the tactile map to a 3D point
            bb_centroid[n] = back_project_centroid(S, T, bb_centroid2d[n], number_of_ids) 
        else:
            bb_centroid2d[n] = []
            bb_centroid[n] = []  

    #AVERAGE NORMAL
    for n in range(bb_number):
        average_normal = [0.0,0.0,0.0]
        if len(total_taxel_normals[n]) != 0:
            for i in range(len(total_taxel_normals[n])):
                average_normal[0] = average_normal[0] - total_taxel_normals[n][i][0]
                average_normal[1] = average_normal[1] - total_taxel_normals[n][i][1]
                average_normal[2] = average_normal[2] - total_taxel_normals[n][i][2]
            average_normal[0] = average_normal[0] / len(total_taxel_normals[n])
            average_normal[1] = average_normal[1] / len(total_taxel_normals[n])
            average_normal[2] = average_normal[2] / len(total_taxel_normals[n])

            bb_normal[n] = average_normal
            #print("Position of Centroid", taxel_predictions_info[n][0], "is", bb_centroid[n])
        else:
            bb_normal[n] = []  

    return total_taxel_responses, average_responses, total_taxels_position, bb_centroid, bb_normal,  total_taxel_normals

def back_project_centroid(S, T, bb_centroid2d, number_of_ids):
    #initializing
    short_dist1 = 10
    short_dist2 = 10
    short_dist3 = 10
    taxel_id1 = 0
    taxel_id2 = 0
    taxel_id3 = 0
    centroid_3d = [0.0,0.0,0.0]
    P = [0.0,0.0,0.0]
    B = [0.0,0.0,0.0]
    C = [0.0,0.0,0.0]

    #find the 3 closest taxels
    for i in range(number_of_ids):
        taxel_coords = T.taxels[i].get_taxel_position()
        x = taxel_coords[0]
        y = taxel_coords[1]
        distance = math.sqrt( math.pow(bb_centroid2d[0] - x,2) + math.pow(bb_centroid2d[1] -y, 2))

        if distance < short_dist1:
            short_dist3 = short_dist2
            short_dist2 = short_dist1
            short_dist1 = distance
            taxel_id3 = taxel_id2
            taxel_id2 = taxel_id1
            taxel_id1 = i
        elif distance < short_dist2:
            short_dist3 = short_dist2 
            short_dist2 = distance
            taxel_id3 = taxel_id2
            taxel_id2 = i
        elif distance < short_dist3:
            short_dist3 = distance
            taxel_id3 = i

    a = T.taxels[taxel_id1].get_taxel_position()
    b = T.taxels[taxel_id2].get_taxel_position()
    c = T.taxels[taxel_id3].get_taxel_position()

    #Compute the cofficents of the convex combination
    P[0] = bb_centroid2d[0]-a[0]; P[1] = bb_centroid2d[1]-a[1];
    B[0] = b[0]-a[0]; B[1] = b[1]-a[1];
    C[0] = c[0]-a[0]; C[1] = c[1]-a[1];
        
    d = B[0]*C[1] - C[0]*B[1];
    wa = ( P[0]*(B[1]-C[1]) + P[1]*(C[0]-B[0]) + B[0]*C[1] - C[0]*B[1] ) / d;
    wb = ( P[0]*C[1] - P[1]*C[0] ) / d;
    wc = ( P[1]*B[0] - P[0]*B[1] ) / d;

    v1 = S.taxels[taxel_id1].get_taxel_position()
    v2 = S.taxels[taxel_id2].get_taxel_position()
    v3 = S.taxels[taxel_id3].get_taxel_position()

    centroid_3d[0] = wa*v1[0] + wb*v2[0] + wc*v3[0];
    centroid_3d[1] = wa*v1[1] + wb*v2[1] + wc*v3[1];
    centroid_3d[2] = wa*v1[2] + wb*v2[2] + wc*v3[2]

    return centroid_3d

def initialize_contact_marker_points(marker_position, color, id):
    marker = Marker()
    marker.id =  id
    marker.header.frame_id = "my_frame"
    marker.header.stamp    = rospy.get_rostime()
    marker.type = marker.POINTS
    marker.action = marker.ADD
    marker.scale.x = 0.04
    marker.scale.y = 0.04
    marker.scale.z = 0.04
    p = Point()
    triplePoints =[]
    quadColor = []
    p.x = marker_position[0]*30
    p.y = marker_position[1]*30
    p.z = marker_position[2]*30
    triplePoints.append(p)
    marker.points = triplePoints
    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0
    c = ColorRGBA()
    c.r = color[0]/255
    c.g = color[1]/255
    c.b = color[2]/255
    c.a = color[3]
    quadColor.append(c)
    marker.colors = quadColor
    marker.lifetime = rospy.Duration(1)

    return marker

def initialize_contact_marker_spheres(marker_position, color, id):
    marker = Marker()
    marker.id =  id
    marker.header.frame_id = "my_frame"
    marker.header.stamp    = rospy.get_rostime()
    marker.type = marker.SPHERE
    marker.action = marker.ADD
    marker.scale.x = 0.02
    marker.scale.y = 0.02
    marker.scale.z = 0.02
    marker.pose.position.x = marker_position[0]*30
    marker.pose.position.y = marker_position[1]*30
    marker.pose.position.z = marker_position[2]*30
    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0
    marker.color.r = color[0]
    marker.color.g = color[1]
    marker.color.b = color[2]
    marker.color.a = color[3]
    marker.lifetime = rospy.Duration(0.2)

    return marker

def initialize_marker_responses(marker_position, bb_normal, average_responses, color, id):
    marker = Marker()
    marker.id =  id
    marker.header.frame_id = "my_frame"
    marker.header.stamp    = rospy.get_rostime()
    marker.type = marker.ARROW
    marker.action = marker.ADD
    marker.action = 0
    marker.scale.x = 0.05
    marker.scale.y = 0.09
    marker.scale.z = 0.05
    marker.pose.orientation.x = 0
    marker.pose.orientation.w = 1.0
    marker.color.r = color[0]
    marker.color.g = color[1]
    marker.color.b = color[2]
    marker.color.a = color[3]
    tail = Point()
    tail.x = marker_position[0]*30
    tail.y = marker_position[1]*30
    tail.z = marker_position[2]*30
    tail_list =[]
    tail_list.append(tail)
    tip = Point()
    tip.x = marker_position[0]*30
    tip.y = bb_normal[1]*average_responses/3000
    tip.z = bb_normal[2]*average_responses/3000
    tip_list =[]
    tip_list.append(tip)
    marker.points = [ tail, tip ]
    marker.lifetime = rospy.Duration(1)

    return marker




