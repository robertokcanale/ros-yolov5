import numpy as np
import argparse
import torch
import cv2
import random
from operator import add 
import time
import rospy
from visualization_msgs.msg import MarkerArray
from visualization_msgs.msg import Marker
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
def taxel_responses(bb_number, S, taxel_predictions, taxel_predictions_info):
    total_taxel_responses = np.empty((bb_number,), dtype = object)
    total_taxels_position = np.empty((bb_number,), dtype = object)
    average_responses = np.empty((bb_number,), dtype = object)
    bb_centroid = np.empty((bb_number,), dtype = object)

    #get total responses
    for n in range(bb_number):
        taxel_response = [] #empty array for the responses of a single bounding box
        taxels_position = [] #empty array for the idus of a single bounding box
        for i in taxel_predictions[n]:
            if S.taxels[i].get_taxel_response() != 0: 
                taxel_response.append(S.taxels[i].get_taxel_response()) 
                taxels_position.append(S.taxels[i].get_taxel_position()) 
        if taxel_response == [] or taxels_position == []:
            total_taxel_responses[n] = []
            total_taxels_position[n] = []
        else: 
            total_taxel_responses[n] = taxel_response
            total_taxels_position[n] = taxels_position
    
    #get average responses including taxels with 0 response
    for n in range(bb_number):
        if len(total_taxels_position[n]) != 0:
            average_response = sum(total_taxel_responses[n])/taxel_predictions_info[n][2]
            average_responses[n] = average_response
            print("Average Response of", taxel_predictions_info[n][0], "is", average_responses[n])
        else:
            average_responses[n] = 0.0
    
     
    #get average response position
    for n in range(bb_number):
        average_position = [0.0,0.0,0.0]
        if len(total_taxels_position[n]) != 0:
            for i in range(len(total_taxels_position[n])):
                average_position[0] = average_position[0] + total_taxels_position[n][i][0]
                average_position[1] = average_position[1] + total_taxels_position[n][i][1]
                average_position[2] = average_position[2] + total_taxels_position[n][i][2]
            average_position[0] = average_position[0] /len(total_taxels_position[n])
            average_position[1] = average_position[1] /len(total_taxels_position[n])
            average_position[2] = average_position[2] /len(total_taxels_position[n])

            bb_centroid[n] = average_position
            #print("Position of Centroid", taxel_predictions_info[n][0], "is", bb_centroid[n])
        else:
            bb_centroid[n] = []
    
    return total_taxel_responses, average_responses, total_taxels_position, bb_centroid


def total_responses_visualization(bb_number, V, pixel_positions, taxel_predictions_info, color_dict):
    if bb_number !=0:
        for n in range(bb_number):
            counter = 0
            contact_color = color_dict[taxel_predictions_info[n][0]]
            for i in range(len(pixel_positions[n])):
                a = random.randint(0,50)
                if a == 4:
                    V.add_marker(50*n+counter,pixel_positions[n][i], contact_color)
                counter += 1



def average_responses_visualization(bb_number, V, bb_centroid, taxel_predictions_info, color_dict ):
    if bb_number !=0:
        for n in range(bb_number):
            contact_color = color_dict[taxel_predictions_info[n][0]]
            V.add_marker((n*30+2*n),bb_centroid[n], contact_color)

def total_faces_visualization(bb_number, V, face_centers, taxel_predictions_info, color_dict):
    if bb_number !=0:
        counter = 0
        for n in range(bb_number):
            contact_color = color_dict[taxel_predictions_info[n][0]]
            for i in range(len(face_centers[n])):
                V.add_marker(counter,face_centers[n][i], contact_color)
                counter += 1

def initialize_marker(marker_position, color, id):
    marker = Marker()
    marker.id =  id
    marker.header.frame_id = "my_frame"
    marker.header.stamp    = rospy.get_rostime()
    marker.type = marker.SPHERE
    marker.action = marker.ADD
    marker.action = 0
    marker.scale.x = 0.08
    marker.scale.y = 0.08
    marker.scale.z = 0.08
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




