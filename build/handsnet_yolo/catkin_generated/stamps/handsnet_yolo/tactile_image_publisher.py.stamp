#!/usr/bin/env python
import rospy
#import tensorflow as tf
from PIL import Image
from sensor_msgs.msg import Image as TactileImage
import numpy as np
import glob

#I can make a message of this type
#sensor_msgs/Image[] data

if __name__ == '__main__':

    pub_hn = rospy.Publisher('tactile_image_hn', TactileImage, queue_size=10)
    #pub_yolo = rospy.Publisher('tactile_image_yolo', TactileImage, queue_size=10)
    rospy.init_node('tactile_image_publisher')

    rate = rospy.Rate(1) # 1hz
    while not rospy.is_shutdown():
        for filename in glob.glob('data/images_2/*.png'): #assuming png
            #PIL image
            im_hn = Image.open(filename).convert('RGB')
            im_hn =  im_hn.resize((68, 100))

            #IMAGE FOR HN
            tactile_image_hn = TactileImage()
            tactile_image_hn.header.frame_id = filename
            tactile_image_hn.header.stamp = rospy.Time.now()
            tactile_image_hn.height = im_hn.height
            tactile_image_hn.width = im_hn.width
            tactile_image_hn.encoding = "rgb8"
            tactile_image_hn.is_bigendian = False
            tactile_image_hn.step = 3 * im_hn.width # Full row length in bytes
            tactile_image_hn.data = np.array(im_hn).tobytes()
            pub_hn.publish(tactile_image_hn)
            
            """ #IMAGE FOR YOLO
            im_yolo = Image.open(filename).convert('RGB')
            im_yolo = im_yolo.resize((416, 416))
            tactile_image_yolo = TactileImage()
            tactile_image_yolo.header.frame_id = filename
            tactile_image_yolo.header.stamp = rospy.Time.now()
            tactile_image_yolo.height = im_yolo.height
            tactile_image_yolo.width = im_yolo.width
            tactile_image_yolo.encoding = "rgb8"
            tactile_image_yolo.is_bigendian = False
            tactile_image_yolo.step = 3 * im_yolo.width # Full row length in bytes
            tactile_image_yolo.data = np.array(im_yolo).tobytes()
            pub_yolo.publish(tactile_image_yolo)
            print(tactile_image_hn.header.frame_id)
            print(im_yolo.size)"""
            rate.sleep()




