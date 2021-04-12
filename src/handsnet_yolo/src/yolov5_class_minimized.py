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
    global model, imgsz, device, names, colors, opt, hand_contact
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
        #CLASS= Torch.tensor
    if hand_contact ==1:
        pred = model(img, augment=opt.augment)[0]
        # Apply NMS
        pred = non_max_suppression(pred, conf_thres, iou_thres, classes=opt.classes,agnostic=opt.agnostic_nms)
        print(pred)
        # Process detections
        for i,det in enumerate(pred):  # detections per image
            s = ''
            s += '%gx%g ' % img.shape[2:]  #string for printinh
            if len(det):
                #print results in s
                for c in det[:, -1].unique():
                    n = (det[:, -1] == c).sum()  # detections per class
                    s += f"{n} {names[int(c)]}{'s' * (n > 1)}, "  # add to string

                #XYXY = BB POSITION
                #CONF = CONFIDENCE SCORE
                #CLS = CLASS 0=finger, 1=palm, 2=thumb, IDK why but it's like that here
                for *xyxy, conf, cls in det:  
                    #print("conf=", conf, "cls=", cls, "xyxy=",xyxy, "\n")
                    label = f'{names[int(cls)]} {conf:.2f}'
                    plot_one_box(xyxy, cv_image, label=label, color=colors[int(cls)], line_thickness=1) #I THINK THIS XYXY IS WHAT I NEED
                    print(xyxy[0].item(),xyxy[1].item(),xyxy[2].item(),xyxy[3].item()) #with item i can access the datam not with 
                    
                    bounding_box.coordinates[0]=xyxy[0].item();
                    bounding_box.coordinates[1]=xyxy[1].item();
                    bounding_box.coordinates[2]=xyxy[2].item();
                    bounding_box.coordinates[3]=xyxy[3].item();


            print(f'Preditction:{s}.')
            # Stream results
            if view_img:  #view_img
                cv2.imshow("Tactile_Image", cv_image)
                cv2.waitKey(1)  # 1 millisecond

    elif hand_contact == 0 or hand_contact == 99:
        print("No Hand To Detect")

#CALLBACK FOR CONTACT
def callback_contact(contact):
    global hand_contact
    if contact.data == 1:
        hand_contact = 1
        #print("Hand")
    elif contact.data == 0:
        hand_contact = 0
        #print("Non_Hand")
    else:
        #print("Not Recognized")
        hand_contact = 99
    

#MAIN
if __name__ == '__main__':
    #INITIALISATION
    parser = argparse.ArgumentParser()
    parser.add_argument('--classes', nargs='+', type=int, help='filter by class: --class 0, or --class 0 2 3')
    parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
    parser.add_argument('--augment', action='store_true', help='augmented inference')

    opt = parser.parse_args()
    weights= 'src/handsnet_yolo/src/data/best_s_6classes.pt' #
    imgsz = 416
    view_img= True
    conf_thres= 0.5
    iou_thres=0.5
    device = '0' #or CPU if needed
    #Global Variables for proper operation of the node
    colors = [[0,0,255], [0,255,0], [255,0,0], [100,110,100], [0,100,100], [100,0,100] ] #6 classes
    #colors = [[0,0,255], [0,255,0], [255,0,0]] #3 classes

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
            #pub.publish(1)
            rate.sleep()
