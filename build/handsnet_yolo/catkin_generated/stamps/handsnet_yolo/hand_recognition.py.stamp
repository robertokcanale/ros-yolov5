#!/usr/bin/env python
import PIL
from numpy.core.fromnumeric import size
import rospy
import numpy as np
import tensorflow as tf
from tensorflow import keras
from std_msgs.msg import Int16
from sensor_msgs.msg import Image as TactileImage
from PIL import Image
import ros_numpy
import os

tactile_image =  np.zeros((1, 100, 68, 3))
yolo_image = TactileImage()

#IMPORTING THE MODEL
def import_model():
    model = tf.keras.models.load_model('data/HandsNet_2.h5')
    model.trainable = False #Freezing the Model
    #model.summary()
    return model

#CALLBACK IMAGE CONVERSION
def callback(data):
    global tactile_image, yolo_image
    cv_image= ros_numpy.numpify(data)
    input_arr= keras.preprocessing.image.img_to_array(cv_image) #Converts to numpy.ndarray
    tactile_image= np.array([input_arr])  #Adds the first dimension

    #preparing YOLO IMAGE
    PIL_image = Image.fromarray(np.uint8(input_arr)).convert('RGB')
    PIL_image=PIL_image.resize((416, 416))
    yolo_image.header.frame_id = data.header.frame_id
    yolo_image.header.stamp = rospy.Time.now()
    yolo_image.height = PIL_image.height
    yolo_image.width = PIL_image.width
    yolo_image.encoding = "rgb8"
    yolo_image.is_bigendian = False
    yolo_image.step = 3 * PIL_image.width # Full row length in bytes
    yolo_image.data = np.array(PIL_image).tobytes()

#RECOGNIZE HAND OR NON_HAND
def hand_recognition(model, image): 
    predictions = model.predict(image)
    if predictions[0,0]>0.9:
        print("Hand")
        return 1 #recognizes hand in contact
    elif predictions[0,1]>0.9:
        print("Non_Hand")
        return 0 #recognizes non_hand in contact
    else: 
        print("Not Recognized")
        return 99 #the software is not sure about it   


#MAIN FUNCTION
if __name__ == '__main__':

    #GPU CHECKS
    gpus = tf.config.experimental.list_physical_devices('GPU')
    if gpus:
        try:
            tf.config.experimental.set_virtual_device_configuration(
            gpus[0],
            [tf.config.experimental.VirtualDeviceConfiguration(memory_limit=1024 * 2)])
            logical_gpus = tf.config.experimental.list_logical_devices('GPU')
            print(len(gpus), "Physical GPUs,", len(logical_gpus), "Logical GPUs")
        except RuntimeError as e:
        # Virtual devices must be set before GPUs have been initialized
            print(e)

    #NODE INITIALIZATION
    rospy.init_node('hand_recognition', anonymous=True)
    pub = rospy.Publisher('hand_contact', Int16, queue_size=10)
    rospy.Subscriber('tactile_image_hn', TactileImage, callback) #this is a rosmsmg.msg Image
    pub_yolo = rospy.Publisher('tactile_image_yolo', TactileImage, queue_size=10)
    rate = rospy.Rate(1) # 1hz

    #MODEL
    HandsNet = import_model()

    #LOOP
    while not rospy.is_shutdown():
        contact_type = hand_recognition(HandsNet, tactile_image)
        pub.publish(contact_type)
        if contact_type == 1:
            pub_yolo.publish(yolo_image)
        rate.sleep()


    

