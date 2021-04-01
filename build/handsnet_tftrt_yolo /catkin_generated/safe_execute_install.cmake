execute_process(COMMAND "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/python_distutils_install.sh) returned error code ")
endif()
