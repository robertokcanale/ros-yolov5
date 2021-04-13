#!/usr/bin/env python
from numpy.core.fromnumeric import size
import rospy
from sensor_msgs.msg import Image as TactileImage
from handsnet_yolo.msg import Image_BB
from handsnet_yolo.msg import BB
from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, \
    scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized

#CALLBACK FOR THE IMAGE
def callback_image(data):
    global bb_number, classes, confidences, coordinates
    bb_number= data.bb_number
    classes = [0] * bb_number
    confidences =[0] * bb_number
    coordinates = [0] * bb_number
        
    for i in range(bb_number):
        classes[i] = data.bb_array[i].obj_class
        confidences[i] = data.bb_array[i].confidence
        coordinates[i] = data.bb_array[i].coordinates

#MAIN
if __name__ == '__main__':
    bb_number = 0
    classes = [0] * bb_number
    confidences =[0] * bb_number
    coordinates = [0] * bb_number

    #NODE INITIALIZATION
    rospy.init_node('BB_receiver')
    rospy.Subscriber('BundingBoxArray', Image_BB, callback_image) #this is a rosmsmg.msg Image

    #RATE
    rate = rospy.Rate(1) # 1hz

    #LOOP   
    while not rospy.is_shutdown():
        
        print("Classes:", classes, "\n", "Confidences:", confidences, "\n", "Coordinates:", coordinates)

        rate.sleep()

