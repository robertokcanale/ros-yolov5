#!/usr/bin/env python
from numpy.core.fromnumeric import size
import rospy
import argparse
from std_msgs.msg import Int16
import cv2
import torch
import numpy as np
from sensor_msgs.msg import Image as TactileImage
from PIL import Image
from cv_bridge import CvBridge
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
    global model, imgsz, device, names, colors, opt, hand_contact, bounding_box_array
    stride = int(model.stride.max())  # model stride
    imgsz = check_img_size(imgsz, s=stride)  # check img_size
    #IMAGE PROCESSING
    cv_image = CvBridge().imgmsg_to_cv2(data, "rgb8") #Here I can Reconstruct my image properly
    new_cv_image = np.transpose(cv_image, (2, 0, 1)) #transposing the image for processing
    img = torch.from_numpy(new_cv_image).to(device)
    img = img.float()  
    img /= 255.0  # 0 - 255 to 0.0 - 1.0

    if img.ndimension() == 3:
        img = img.unsqueeze(0)
    if hand_contact == 1: #check the flag
        pred = model(img, augment=opt.augment)[0]
        pred = non_max_suppression(pred, conf_thres, iou_thres, classes=opt.classes,agnostic=opt.agnostic_nms)
        
        # Process detections
        for i,det in enumerate(pred):  # detections per image
            s = ''
            s += '%gx%g ' % img.shape[2:]  #string for printing
            if len(det):
                for c in det[:, -1].unique(): #print results in s I only need it if i want to print the stuff
                    n = (det[:, -1] == c).sum()  # detections per class
                    s += f"{n} {names[int(c)]}{'s' * (n > 1)} "  # add to string
                #Printing on the Image
                for *xyxy, conf, cls in det: 
                    label = f'{names[int(cls)]} {conf:.2f}'
                    plot_one_box(xyxy, cv_image, label=label, color=colors[int(cls)], line_thickness=1) #I THINK THIS XYXY IS WHAT I NEED
            #GENERATE MESSAGE
            bb_message(det)
            print(f'Preditction:{s}.')
            # Stream results
            if view_img:  #view_img
                cv2.imshow("Tactile_Image", cv_image)
                cv2.waitKey(1)  # 1 millisecond

    elif hand_contact == 0 or hand_contact == 99:
        print("No Hand To Detect")

#BB_MESSAGE
def bb_message(det):
    global bounding_box_array
    #CREATE MESSAGE TO PUBLISH  
    bounding_box_array.bb_number = int(len(det)) # set the number of predictions 
    bounding_box_array.bb_array = [0] * bounding_box_array.bb_number #create an empty list of that size

    for i in range(bounding_box_array.bb_number): #scan the prediction matrix DET/PRED (they are the same)
        bounding_box = BB() #initialize an empty BB and initialize my array
        bounding_box.coordinates=[det[i][0].item(),det[i][1].item(),det[i][2].item(),det[i][3].item()] 
        bounding_box.confidence = det[i][4].item()
        bounding_box.obj_class = names[int(det[i][5].item())]
        bounding_box_array.bb_array[i] = bounding_box

    return bounding_box_array

#CALLBACK FOR CONTACT
def callback_contact(contact):
    global hand_contact
    if contact.data == 1:
        hand_contact = 1
    elif contact.data == 0:
        hand_contact = 0
    else:
        hand_contact = 99

#MAIN
if __name__ == '__main__':
    #INITIALISATION
    parser = argparse.ArgumentParser()
    parser.add_argument('--classes', nargs='+', type=int, help='filter by class: --class 0, or --class 0 2 3')
    parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
    parser.add_argument('--augment', action='store_true', help='augmented inference')
    opt = parser.parse_args()
    weights = 'src/handsnet_yolo/src/data/best_finetune3.pt' 
    imgsz = 416
    view_img = True
    conf_thres = 0.5
    iou_thres = 0.5
    device = '0' #or CPU if needed
    bounding_box_array = Image_BB()
    #colors = [[0,0,255], [0,255,0], [255,0,0], [100,100,100], [0,50,150], [75,150,0] ] #6 classes
    colors = [[0,0,255], [0,255,0], [255,0,0]] #3 classes
    #GPU
    set_logging()
    device = select_device(device)

    #MODEL
    model = attempt_load(weights, map_location=device)
    # Get names and colors
    names = model.module.names if hasattr(model, 'module') else model.names

    #NODE INITIALIZATION
    rospy.init_node('hand_classification')
    pub = rospy.Publisher('BundingBoxArray', Image_BB, queue_size=10)
    rospy.Subscriber('tactile_image_yolo', TactileImage, callback_image) #this is a rosmsmg.msg Image
    rospy.Subscriber('hand_contact', Int16, callback_contact) #this is a rosmsmg.msg Image

    #RATE
    rate = rospy.Rate(1) # 1hz

    #LOOP
    with torch.no_grad():    
        while not rospy.is_shutdown():
            print(bounding_box_array)
            pub.publish(bounding_box_array)
            rate.sleep()

