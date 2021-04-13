; Auto-generated. Do not edit!


(cl:in-package handsnet_tftrt_yolo-msg)


;//! \htmlinclude BB.msg.html

(cl:defclass <BB> (roslisp-msg-protocol:ros-message)
  ((obj_class
    :reader obj_class
    :initarg :obj_class
    :type cl:string
    :initform "")
   (confidence
    :reader confidence
    :initarg :confidence
    :type cl:float
    :initform 0.0)
   (coordinates
    :reader coordinates
    :initarg :coordinates
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass BB (<BB>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BB>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BB)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name handsnet_tftrt_yolo-msg:<BB> is deprecated: use handsnet_tftrt_yolo-msg:BB instead.")))

(cl:ensure-generic-function 'obj_class-val :lambda-list '(m))
(cl:defmethod obj_class-val ((m <BB>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader handsnet_tftrt_yolo-msg:obj_class-val is deprecated.  Use handsnet_tftrt_yolo-msg:obj_class instead.")
  (obj_class m))

(cl:ensure-generic-function 'confidence-val :lambda-list '(m))
(cl:defmethod confidence-val ((m <BB>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader handsnet_tftrt_yolo-msg:confidence-val is deprecated.  Use handsnet_tftrt_yolo-msg:confidence instead.")
  (confidence m))

(cl:ensure-generic-function 'coordinates-val :lambda-list '(m))
(cl:defmethod coordinates-val ((m <BB>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader handsnet_tftrt_yolo-msg:coordinates-val is deprecated.  Use handsnet_tftrt_yolo-msg:coordinates instead.")
  (coordinates m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BB>) ostream)
  "Serializes a message object of type '<BB>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'obj_class))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'obj_class))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'confidence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'coordinates))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'coordinates))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BB>) istream)
  "Deserializes a message object of type '<BB>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'obj_class) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'obj_class) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'confidence) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'coordinates) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'coordinates)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BB>)))
  "Returns string type for a message object of type '<BB>"
  "handsnet_tftrt_yolo/BB")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BB)))
  "Returns string type for a message object of type 'BB"
  "handsnet_tftrt_yolo/BB")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BB>)))
  "Returns md5sum for a message object of type '<BB>"
  "dfc87673751af1dddbaefa01947e8324")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BB)))
  "Returns md5sum for a message object of type 'BB"
  "dfc87673751af1dddbaefa01947e8324")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BB>)))
  "Returns full string definition for message of type '<BB>"
  (cl:format cl:nil "string obj_class~%float32 confidence~%float32[] coordinates~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BB)))
  "Returns full string definition for message of type 'BB"
  (cl:format cl:nil "string obj_class~%float32 confidence~%float32[] coordinates~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BB>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'obj_class))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'coordinates) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BB>))
  "Converts a ROS message object to a list"
  (cl:list 'BB
    (cl:cons ':obj_class (obj_class msg))
    (cl:cons ':confidence (confidence msg))
    (cl:cons ':coordinates (coordinates msg))
))
