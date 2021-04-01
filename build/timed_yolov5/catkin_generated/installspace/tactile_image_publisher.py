#!/usr/bin/env python3
import rospy
#import tensorflow as tf
from PIL import Image
from sensor_msgs.msg import Image as TactileImage
import numpy as np
import glob

#I can make a message of this type
#sensor_msgs/Image[] data

if __name__ == '__main__':

    pub = rospy.Publisher('tactile_image', TactileImage, queue_size=10)
    rospy.init_node('tactile_image_publisher')

    rate = rospy.Rate(1000) # 1hz
    while not rospy.is_shutdown():
        for filename in glob.glob('data/images/*.jpg'): #assuming gif
            #PIL image
            im = Image.open(filename).convert('RGB') 
            #sensor_msgs.msg.Image
            tactile_image = TactileImage()
            tactile_image.header.frame_id = filename
            tactile_image.header.stamp = rospy.Time.now()
            tactile_image.height = im.height
            tactile_image.width = im.width
            tactile_image.encoding = "rgb8"
            tactile_image.is_bigendian = False
            tactile_image.step = 3 * im.width # Full row length in bytes
            tactile_image.data = np.array(im).tobytes()
            pub.publish(tactile_image)
            print(tactile_image.header.frame_id)
            rate.sleep()




