#!/usr/bin/env python
from numpy.core.fromnumeric import size
import rospy
from sensor_msgs.msg import Image as TactileImage
from std_msgs.msg import Int16
import ros_numpy
import random
import cv2
from handsnet_yolo.msg import Image_BB
from handsnet_yolo.msg import BB
from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, \
    scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized

#This is an attempt to plot the BB on the reshaped image and IT WORKS, the image is just delayed, as it plots 
#on the image on a much forward image, but ultimately this:
#correctly acquires the data from the message
#has a working reshape function 
#can plot labels on a image of different shape. 
#some stuff can me removed it was just to see what happens


#CALLBACK FOR THE BB
def callback_BB(data):
    global bb_number, classes, confidences, coordinates
    bb_number= data.bb_number
    classes = [0] * bb_number
    confidences =[0] * bb_number
    coordinates = [0] * bb_number
        
    for i in range(bb_number):
        classes[i] = data.bb_array[i].obj_class
        confidences[i] = data.bb_array[i].confidence
        coordinates[i] = data.bb_array[i].coordinates


#CALLBACK FOR THE IMAGE
def callback_image(data):
    global bb_number, classes, confidences, coordinates, colors
    cv_image= ros_numpy.numpify(data)

    for i in range(bb_number):  
        label = f'{classes[i]} {confidences[i]:.2f}'
        xyxy = reshape_coordinates_bb(coordinates[i], 416, 416, 68, 100)
        print(xyxy, type(xyxy), len(xyxy))
       
        plot_one_box(xyxy, cv_image, label=label, color=colors[random.randint(0,2)], line_thickness=1)  #the randint is a bit casual
    
    cv2.imshow("Tactile_Image", cv_image) #shows a much forward image, it's jsut a question to give it the same image as yolo, I should ahve YOLO pass the image it receives and the flag to this one
    cv2.waitKey(1)  # 1 millisecond

#reshaping the coordinates of my BB, this one work
def reshape_coordinates_bb (coord_i, width_i, height_i, width_o, height_o):
    coord_o = [0] * len(coord_i)
    for i in range(len(coord_i)):
        coord_o[0] =max(float(0), coord_i[0]*width_o/width_i )  #x1
        coord_o[1] =max(float(0), coord_i[1]*height_o/height_i)   #y1
        coord_o[2] =max(float(0), coord_i[2]*width_o/width_i) #x2
        coord_o[3] =max(float(0), coord_i[3]*height_o/height_i )  #y2
    return coord_o




#MAIN
if __name__ == '__main__':
    bb_number = 0
    classes = [0] * bb_number
    confidences =[0] * bb_number
    coordinates = [0] * bb_number
    #colors = [[0,0,255], [0,255,0], [255,0,0], [100,100,100], [0,50,150], [75,150,0] ] #6 classes
    colors = [[0,0,255], [0,255,0], [255,0,0]] #3 classes
   
    #NODE INITIALIZATION
    rospy.init_node('BB_receiver')
    rospy.Subscriber('BundingBoxArray', Image_BB, callback_BB) #this is a rosmsmg.msg Image
    rospy.Subscriber('tactile_image_hn', TactileImage, callback_image) #this is a rosmsmg.msg Image

    #RATE
    rate = rospy.Rate(1) # 1hz
    
    #LOOP   
    while not rospy.is_shutdown():
        
        print("Classes:", classes, "\n", "Confidences:", confidences, "\n", "Coordinates:", coordinates)

        rate.sleep()

