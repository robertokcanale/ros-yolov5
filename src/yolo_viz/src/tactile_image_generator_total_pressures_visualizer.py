import pyrobotskinlib as rsl 
import numpy as np
import rospy
from cv2 import cvtColor, resize, imshow, waitKey,  INTER_AREA, COLOR_GRAY2RGB
from cv_bridge import CvBridge
from  time import sleep 
from functions import *
from sensor_msgs.msg import Image
from visualization_msgs.msg import MarkerArray           

from functions.functions_hn import *

#MAIN
if __name__ == '__main__':
    #ROS INITIALIZATION
    rospy.init_node('markers_publisher', anonymous=True)
    contact_pub = rospy.Publisher('yolo_contact', MarkerArray, queue_size=10)
    arrow_pub = rospy.Publisher('yolo_contact_average', MarkerArray, queue_size=10)
    img_pub = rospy.Publisher('yolo_image', Image, queue_size=10)
    br = CvBridge()

    #LOAD TACTILE IMAGE & SKIN PROPERTIES
    S = rsl.RobotSkin("src/yolo_viz/src/calibration_files/collaborate_handle_1_ale.json")
    u = rsl.SkinUpdaterFromShMem(S)
    T = rsl.TactileMap(S,0)# from here i do 0,1,2,3 i can create differenti images from different patches
    TIB = rsl.TactileImageBuilder(T)
    TIB.build_tactile_image()
    u.start_robot_skin_updater()
    rows = TIB.get_rows()
    cols = TIB.get_cols()
    
    skin_faces = S.get_faces()
    number_of_faces = len(skin_faces)
    taxel_ids = S.get_taxel_ids()
    number_of_ids = len(taxel_ids)
    #taxel_coords = np.zeros((number_of_ids,3))
    #taxel_coords = [T.taxels[i].get_taxel_position() for i in range(number_of_ids)]

    while 1:
        #ACQUIRE DATA
        u.make_this_thread_wait_for_new_data()
        #IMAGE PROCESSING AND PREDICTION
        I = np.array(TIB.get_tactile_image(),np.uint8) #get the image 
        I = I.reshape([rows,cols]) #reshape it into a 2d array
        im_to_show = resize(I, (500, 500), interpolation = INTER_AREA)


        #Get Total Taxels Responses and Positions
        total_taxel_response, total_taxel_3d_position, total_taxel_normal, total_taxel_2d_position= get_taxel_data(S,T, number_of_ids)
        #centroid2d, centroid3d = get_centroid(S,T, total_taxel_2d_position, taxel_coords)
        contacts = initialize_contacts( total_taxel_3d_position)
        contact_pub.publish(contacts)

        #Active taxels distance from [0,0,0]
        #r = get_distance_from_center(total_taxel_positions,total_taxel_response) 
        #Active taxels distance from [x,0,0], the cylinder axis
        #r_axis = get_distance_from_axis(total_taxel_positions, total_taxel_response)
        #total_vector_force, integral_force = find_vector_forces(total_taxel_response, total_taxel_normal)
        #total_vector_moment, integral_moment = find_vector_moments(total_vector_force, centroid3d, total_taxel_3d_position)
        #total_vector_moment, integral_moment =   find_vector_moments_from_center(total_vector_force, total_taxel_3d_position)
        #print("Total Force", total_vector_force)
        #print("Total Moment", total_vector_moment)

        img_pub.publish(br.cv2_to_imgmsg(im_to_show))
        #sleep(0.001)