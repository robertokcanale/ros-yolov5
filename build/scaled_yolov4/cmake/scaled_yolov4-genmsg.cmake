# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "scaled_yolov4: 2 messages, 0 services")

set(MSG_I_FLAGS "-Iscaled_yolov4:/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(scaled_yolov4_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg" NAME_WE)
add_custom_target(_scaled_yolov4_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "scaled_yolov4" "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg" ""
)

get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg" NAME_WE)
add_custom_target(_scaled_yolov4_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "scaled_yolov4" "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg" "scaled_yolov4/BB"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/scaled_yolov4
)
_generate_msg_cpp(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/scaled_yolov4
)

### Generating Services

### Generating Module File
_generate_module_cpp(scaled_yolov4
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/scaled_yolov4
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(scaled_yolov4_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(scaled_yolov4_generate_messages scaled_yolov4_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_cpp _scaled_yolov4_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_cpp _scaled_yolov4_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(scaled_yolov4_gencpp)
add_dependencies(scaled_yolov4_gencpp scaled_yolov4_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS scaled_yolov4_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/scaled_yolov4
)
_generate_msg_eus(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/scaled_yolov4
)

### Generating Services

### Generating Module File
_generate_module_eus(scaled_yolov4
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/scaled_yolov4
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(scaled_yolov4_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(scaled_yolov4_generate_messages scaled_yolov4_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_eus _scaled_yolov4_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_eus _scaled_yolov4_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(scaled_yolov4_geneus)
add_dependencies(scaled_yolov4_geneus scaled_yolov4_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS scaled_yolov4_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/scaled_yolov4
)
_generate_msg_lisp(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/scaled_yolov4
)

### Generating Services

### Generating Module File
_generate_module_lisp(scaled_yolov4
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/scaled_yolov4
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(scaled_yolov4_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(scaled_yolov4_generate_messages scaled_yolov4_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_lisp _scaled_yolov4_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_lisp _scaled_yolov4_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(scaled_yolov4_genlisp)
add_dependencies(scaled_yolov4_genlisp scaled_yolov4_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS scaled_yolov4_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/scaled_yolov4
)
_generate_msg_nodejs(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/scaled_yolov4
)

### Generating Services

### Generating Module File
_generate_module_nodejs(scaled_yolov4
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/scaled_yolov4
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(scaled_yolov4_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(scaled_yolov4_generate_messages scaled_yolov4_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_nodejs _scaled_yolov4_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_nodejs _scaled_yolov4_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(scaled_yolov4_gennodejs)
add_dependencies(scaled_yolov4_gennodejs scaled_yolov4_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS scaled_yolov4_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/scaled_yolov4
)
_generate_msg_py(scaled_yolov4
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg"
  "${MSG_I_FLAGS}"
  "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/scaled_yolov4
)

### Generating Services

### Generating Module File
_generate_module_py(scaled_yolov4
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/scaled_yolov4
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(scaled_yolov4_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(scaled_yolov4_generate_messages scaled_yolov4_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_py _scaled_yolov4_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/maclab/Documents/RCanale/ros-yolov5/src/scaled_yolov4/msg/Image_BB.msg" NAME_WE)
add_dependencies(scaled_yolov4_generate_messages_py _scaled_yolov4_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(scaled_yolov4_genpy)
add_dependencies(scaled_yolov4_genpy scaled_yolov4_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS scaled_yolov4_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/scaled_yolov4)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/scaled_yolov4
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(scaled_yolov4_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/scaled_yolov4)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/scaled_yolov4
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(scaled_yolov4_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/scaled_yolov4)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/scaled_yolov4
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(scaled_yolov4_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/scaled_yolov4)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/scaled_yolov4
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(scaled_yolov4_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/scaled_yolov4)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/scaled_yolov4\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/scaled_yolov4
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(scaled_yolov4_generate_messages_py std_msgs_generate_messages_py)
endif()
