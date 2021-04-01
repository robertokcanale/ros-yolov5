#!/usr/bin/env python3
import rospy
import argparse
import time
import os
from std_msgs.msg import Int16
import cv2
import torch
import numpy as np
from torch._C import Size
import torch.backends.cudnn as cudnn
from sensor_msgs.msg import Image as TactileImage
from PIL import Image
from cv_bridge import CvBridge, CvBridgeError

from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, \
    scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized

#Global Variables for proper operation of the node
model = 0
imgsz = 0
device = '0'
names = []
colors = [[0,0,255], [0,255,0], [255,0,0]]
opt= 0
hand_contact = 0

#CALLBACK FOR THE IMAGE
def callback_image(data):
    global model, imgsz, device, names, colors, opt, hand_contact
    stride = int(model.stride.max())  # model stride
    imgsz = check_img_size(imgsz, s=stride)  # check img_size
    t0 = time.time()
    #IMAGE PROCESSING
    t1 = time_synchronized()
    cv_image = CvBridge().imgmsg_to_cv2(data, "rgb8") #Here I can Reconstruct my image properly
    new_cv_image = np.transpose(cv_image, (2, 0, 1)) #transposing the image for processing

    # Run inference with time
    img = torch.from_numpy(new_cv_image).to(device)
    img = img.float()  
    img /= 255.0  # 0 - 255 to 0.0 - 1.0
    if img.ndimension() == 3:
        img = img.unsqueeze(0)
        #CLASS= Torch.tensor
    if hand_contact ==1:
        pred = model(img, augment=opt.augment)[0]

        # Apply NMS
        pred = non_max_suppression(pred, conf_thres, iou_thres, classes=opt.classes, 	agnostic=opt.agnostic_nms)
        t2 = time_synchronized()


        # Process detections
        for i,det in enumerate(pred):  # detections per image
            s = ''
            s += '%gx%g ' % img.shape[2:]  #string for printinh
            if len(det):
                # Rescale boxes from img_size to im0 size -> USELSS if imgs have the same declared size, 416
                #det[:, :4] = scale_coords(img.shape[2:], det[:, :4], new_cv_image.shape).round()
                # Print results
                for c in det[:, -1].unique():
                    n = (det[:, -1] == c).sum()  # detections per class
                    s += f"{n} {names[int(c)]}{'s' * (n > 1)}, "  # add to string

                #These are all pytorch tensors and they store the value in the first thingy
                #XYXY = BB POSITION
                #CONF = CONFIDENCE SCORE
                #CLS = CLASS 0=finger, 1=palm, 2=thumb, IDK why but it's like that here
                for *xyxy, conf, cls in reversed(det):  
                    #print("conf=", conf, "cls=", cls, "xyxy=",xyxy, "\n")
                    label = f'{names[int(cls)]} {conf:.2f}'
                    plot_one_box(xyxy, cv_image, label=label, color=colors[int(cls)], line_thickness=3) #I THINK THIS XYXY IS WHAT I NEED

            # Print time (inference + NMS)
            print(f'{s}Done. ({t2 - t1:.3f}s)')

            # Stream results
            if view_img:  #view_img
                cv2.imshow("Tactile_Image", cv_image)
                cv2.waitKey(1)  # 1 millisecond

        print(f'Done. ({time.time() - t0:.3f}s)')

    elif hand_contact == 0 or hand_contact == 99:
        print("No Hand To Detect")

#CALLBACK FOR CONTACT
def callback_contact(contact):
    global hand_contact
    if contact.data == 1:
        hand_contact = 1
        print("Hand")
    elif contact.data == 0:
        hand_contact = 0
        print("Non_Hand")
    else:
        print("Not Recognized")
        hand_contact = 99
    

if __name__ == '__main__':
    cwd = os.getcwd()
    print(cwd)
    #INITIALISATION
    parser = argparse.ArgumentParser()
    parser.add_argument('--classes', nargs='+', type=int, help='filter by class: --class 0, or --class 0 2 3')
    parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
    parser.add_argument('--augment', action='store_true', help='augmented inference')

    opt = parser.parse_args()
    weights= 'src/handsnet_yolo/src/data/best_finetune3.pt' #
    imgsz = 416
    view_img= True
    conf_thres= 0.5
    iou_thres=0.5
    device = '0'
    #GPU
    set_logging()
    device = select_device(device)

    #MODEL
    model = attempt_load(weights, map_location=device)
    # Get names and colors
    names = model.module.names if hasattr(model, 'module') else model.names
    #colors = [[random.randint(0, 255) for _ in range(3)] for _ in names]

    rospy.init_node('hand_classification')
    pub = rospy.Publisher('BundingBox', Int16, queue_size=10)
    rospy.Subscriber('tactile_image_yolo', TactileImage, callback_image) #this is a rosmsmg.msg Image
    rospy.Subscriber('hand_contact', Int16, callback_contact) #this is a rosmsmg.msg Image

    rate = rospy.Rate(1) # 1hz
    with torch.no_grad():    
        while not rospy.is_shutdown():
            pub.publish(1)
            rate.sleep()

