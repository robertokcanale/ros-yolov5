# Install script for directory: /home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo 

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/maclab/Documents/RCanale/ros-yolov5/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  include("/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/safe_execute_install.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/handsnet_tftrt_yolo/msg" TYPE FILE FILES
    "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
    "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/handsnet_tftrt_yolo/cmake" TYPE FILE FILES "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/handsnet_tftrt_yolo-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/maclab/Documents/RCanale/ros-yolov5/devel/include/handsnet_tftrt_yolo")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/maclab/Documents/RCanale/ros-yolov5/devel/share/roseus/ros/handsnet_tftrt_yolo")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/maclab/Documents/RCanale/ros-yolov5/devel/share/common-lisp/ros/handsnet_tftrt_yolo")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/maclab/Documents/RCanale/ros-yolov5/devel/share/gennodejs/ros/handsnet_tftrt_yolo")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/maclab/Documents/RCanale/ros-yolov5/devel/lib/python3/dist-packages/handsnet_tftrt_yolo")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/maclab/Documents/RCanale/ros-yolov5/devel/lib/python3/dist-packages/handsnet_tftrt_yolo")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/handsnet_tftrt_yolo.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/handsnet_tftrt_yolo/cmake" TYPE FILE FILES "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/handsnet_tftrt_yolo-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/handsnet_tftrt_yolo/cmake" TYPE FILE FILES
    "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/handsnet_tftrt_yoloConfig.cmake"
    "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/handsnet_tftrt_yoloConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/handsnet_tftrt_yolo" TYPE FILE FILES "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/handsnet_tftrt_yolo" TYPE PROGRAM FILES "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/yolov5_classification.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/handsnet_tftrt_yolo" TYPE PROGRAM FILES "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/tactile_image_publisher.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/handsnet_tftrt_yolo" TYPE PROGRAM FILES "/home/maclab/Documents/RCanale/ros-yolov5/build/handsnet_tftrt_yolo /catkin_generated/installspace/hand_tftrt_recognition.py")
endif()

