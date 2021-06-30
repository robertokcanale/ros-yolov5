from visualization_msgs.msg import Marker
from geometry_msgs.msg import Point
from visualization_msgs.msg import MarkerArray
from std_msgs.msg import ColorRGBA
from random import randint
import rospy

def initialize_contact_marker_points(marker_position, color, id):
    marker = Marker()
    marker.id =  id
    marker.header.frame_id = "my_frame"
    marker.header.stamp    = rospy.get_rostime()
    marker.type = marker.POINTS
    marker.action = marker.ADD
    marker.scale.x = 0.04
    marker.scale.y = 0.04
    marker.scale.z = 0.04
    p = Point()
    triplePoints =[]
    quadColor = []
    p.x = marker_position[0]*40
    p.y = marker_position[1]*40
    p.z = marker_position[2]*40
    triplePoints.append(p)
    marker.points = triplePoints
    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0
    c = ColorRGBA()
    c.r = color[0]/255
    c.g = color[1]/255
    c.b = color[2]/255
    c.a = color[3]
    quadColor.append(c)
    marker.colors = quadColor
    marker.lifetime = rospy.Duration(0.1)

    return marker

def initialize_contact_marker_spheres(marker_position, color, id):
    marker = Marker()
    marker.id =  id
    marker.header.frame_id = "my_frame"
    marker.header.stamp    = rospy.get_rostime()
    marker.type = marker.SPHERE
    marker.action = marker.ADD
    marker.scale.x = 0.06
    marker.scale.y = 0.06
    marker.scale.z = 0.06
    marker.pose.position.x = marker_position[0]*40
    marker.pose.position.y = marker_position[1]*40
    marker.pose.position.z = marker_position[2]*40
    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0
    marker.color.r = color[0]
    marker.color.g = color[1]
    marker.color.b = color[2]
    marker.color.a = color[3]
    marker.lifetime = rospy.Duration(0.3)

    return marker

def initialize_marker_responses(marker_position, axis, response, color, id):
    marker = Marker()
    marker.id =  id
    marker.header.frame_id = "my_frame"
    marker.header.stamp    = rospy.get_rostime()
    marker.type = marker.ARROW
    marker.action = marker.ADD
    marker.action = 0
    marker.scale.x = 0.04
    marker.scale.y = 0.08
    marker.scale.z = 0.04
    marker.pose.orientation.x = 0
    marker.pose.orientation.w = 1.0
    marker.color.r = color[0]
    marker.color.g = color[1]
    marker.color.b = color[2]
    marker.color.a = color[3]
    tail = Point()
    tail.x = marker_position[0]*40
    tail.y = marker_position[1]*40
    tail.z = marker_position[2]*40
    tail_list =[]
    tail_list.append(tail)
    tip = Point()
    tip.x = marker_position[0]*40
    tip.y = axis[1]*response /4000
    tip.z = axis[2]*response /4000
    tip_list =[]
    tip_list.append(tip)
    marker.points = [ tail, tip ]
    marker.lifetime = rospy.Duration(0.3)

    return marker

def initialize_taxel_normals(bb_number, total_taxel_normals, total_taxels_3D_position, taxel_predictions_info, color_dict):
    taxel_normal_array  = MarkerArray()
    counter = 0
    for n in range(bb_number):
        contact_color = color_dict[taxel_predictions_info[n][0]]
        for i, pos in enumerate(total_taxels_3D_position[n]):
            marker = initialize_marker_responses(pos, total_taxel_normals[n][i], 0, contact_color, (n*100 +counter))
            taxel_normal_array.markers.append(marker)
            counter +=1
    return taxel_normal_array

def initialize_taxel_forces(bb_number, total_taxels_3D_position,total_bb_forces, taxel_predictions_info, color_dict):
    taxel_forces_array  = MarkerArray()
    counter = 0
    for n in range(bb_number):
        contact_color = color_dict[taxel_predictions_info[n][0]]
        for i, pos in enumerate(total_taxels_3D_position[n]):
            if (total_bb_forces[n][i][1] > 200 or total_bb_forces[n][i][1] < -200) and (total_bb_forces[n][i][2] > 200 or total_bb_forces[n][i][2] < -200):
                marker = initialize_marker_responses(pos, total_bb_forces[n][i], 1, contact_color, (n*100 +counter))
                taxel_forces_array.markers.append(marker)
                counter +=1
    return taxel_forces_array
    
#VISUALIZE Total Normals on Rviz
def initialize_avg_response_normals(bb_number, bb_normal, average_responses, taxel_predictions_info, bb_centroid3d, color_dict):
    normal_array  = MarkerArray()
    counter = 0
    for n in range(bb_number):
        contact_color = color_dict[taxel_predictions_info[n][0]]
        if bb_centroid3d[n] == []:
            break
        marker = initialize_marker_responses(bb_centroid3d[n], bb_normal[n], average_responses[n], contact_color, (n*100 +counter))
        normal_array.markers.append(marker)
        counter +=1
    return normal_array

def initialize_contacts(bb_number, pixel_positions, taxel_predictions_info, color_dict):
    bb_contacts  = MarkerArray()
    for n in range(bb_number):
        contact_color = color_dict[taxel_predictions_info[n][0]]
        counter = 0
        for i in range(len(pixel_positions[n])):
            marker = initialize_contact_marker_spheres(pixel_positions[n][i], contact_color,(n*100 +counter))
            a = randint(0,10)
            if a == 5:
                bb_contacts.markers.append(marker)
            counter +=1
    return bb_contacts



