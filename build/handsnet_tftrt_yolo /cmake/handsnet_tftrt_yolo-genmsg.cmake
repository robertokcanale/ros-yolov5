# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "handsnet_tftrt_yolo: 2 messages, 0 services")

set(MSG_I_FLAGS "-Ihandsnet_tftrt_yolo:/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(handsnet_tftrt_yolo_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg" NAME_WE)
add_custom_target(_handsnet_tftrt_yolo_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "handsnet_tftrt_yolo" "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg" ""
)

get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg" NAME_WE)
add_custom_target(_handsnet_tftrt_yolo_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "handsnet_tftrt_yolo" "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg" "handsnet_tftrt_yolo/BB"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/handsnet_tftrt_yolo
)
_generate_msg_cpp(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/handsnet_tftrt_yolo
)

### Generating Services

### Generating Module File
_generate_module_cpp(handsnet_tftrt_yolo
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/handsnet_tftrt_yolo
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(handsnet_tftrt_yolo_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(handsnet_tftrt_yolo_generate_messages handsnet_tftrt_yolo_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_cpp _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_cpp _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(handsnet_tftrt_yolo_gencpp)
add_dependencies(handsnet_tftrt_yolo_gencpp handsnet_tftrt_yolo_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS handsnet_tftrt_yolo_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/handsnet_tftrt_yolo
)
_generate_msg_eus(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/handsnet_tftrt_yolo
)

### Generating Services

### Generating Module File
_generate_module_eus(handsnet_tftrt_yolo
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/handsnet_tftrt_yolo
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(handsnet_tftrt_yolo_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(handsnet_tftrt_yolo_generate_messages handsnet_tftrt_yolo_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_eus _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_eus _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(handsnet_tftrt_yolo_geneus)
add_dependencies(handsnet_tftrt_yolo_geneus handsnet_tftrt_yolo_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS handsnet_tftrt_yolo_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/handsnet_tftrt_yolo
)
_generate_msg_lisp(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/handsnet_tftrt_yolo
)

### Generating Services

### Generating Module File
_generate_module_lisp(handsnet_tftrt_yolo
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/handsnet_tftrt_yolo
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(handsnet_tftrt_yolo_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(handsnet_tftrt_yolo_generate_messages handsnet_tftrt_yolo_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_lisp _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_lisp _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(handsnet_tftrt_yolo_genlisp)
add_dependencies(handsnet_tftrt_yolo_genlisp handsnet_tftrt_yolo_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS handsnet_tftrt_yolo_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/handsnet_tftrt_yolo
)
_generate_msg_nodejs(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/handsnet_tftrt_yolo
)

### Generating Services

### Generating Module File
_generate_module_nodejs(handsnet_tftrt_yolo
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/handsnet_tftrt_yolo
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(handsnet_tftrt_yolo_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(handsnet_tftrt_yolo_generate_messages handsnet_tftrt_yolo_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_nodejs _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_nodejs _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(handsnet_tftrt_yolo_gennodejs)
add_dependencies(handsnet_tftrt_yolo_gennodejs handsnet_tftrt_yolo_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS handsnet_tftrt_yolo_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/handsnet_tftrt_yolo
)
_generate_msg_py(handsnet_tftrt_yolo
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/handsnet_tftrt_yolo
)

### Generating Services

### Generating Module File
_generate_module_py(handsnet_tftrt_yolo
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/handsnet_tftrt_yolo
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(handsnet_tftrt_yolo_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(handsnet_tftrt_yolo_generate_messages handsnet_tftrt_yolo_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_py _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/handsnet_tftrt_yolo /msg/Image_BB.msg" NAME_WE)
add_dependencies(handsnet_tftrt_yolo_generate_messages_py _handsnet_tftrt_yolo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(handsnet_tftrt_yolo_genpy)
add_dependencies(handsnet_tftrt_yolo_genpy handsnet_tftrt_yolo_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS handsnet_tftrt_yolo_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/handsnet_tftrt_yolo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/handsnet_tftrt_yolo
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(handsnet_tftrt_yolo_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/handsnet_tftrt_yolo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/handsnet_tftrt_yolo
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(handsnet_tftrt_yolo_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/handsnet_tftrt_yolo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/handsnet_tftrt_yolo
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(handsnet_tftrt_yolo_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/handsnet_tftrt_yolo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/handsnet_tftrt_yolo
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(handsnet_tftrt_yolo_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/handsnet_tftrt_yolo)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/handsnet_tftrt_yolo\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/handsnet_tftrt_yolo
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(handsnet_tftrt_yolo_generate_messages_py std_msgs_generate_messages_py)
endif()
