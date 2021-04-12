; Auto-generated. Do not edit!


(cl:in-package handsnet_tftrt_yolo-msg)


;//! \htmlinclude Image_BB.msg.html

(cl:defclass <Image_BB> (roslisp-msg-protocol:ros-message)
  ((bb_number
    :reader bb_number
    :initarg :bb_number
    :type cl:fixnum
    :initform 0)
   (bb_array
    :reader bb_array
    :initarg :bb_array
    :type (cl:vector handsnet_tftrt_yolo-msg:BB)
   :initform (cl:make-array 0 :element-type 'handsnet_tftrt_yolo-msg:BB :initial-element (cl:make-instance 'handsnet_tftrt_yolo-msg:BB))))
)

(cl:defclass Image_BB (<Image_BB>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Image_BB>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Image_BB)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name handsnet_tftrt_yolo-msg:<Image_BB> is deprecated: use handsnet_tftrt_yolo-msg:Image_BB instead.")))

(cl:ensure-generic-function 'bb_number-val :lambda-list '(m))
(cl:defmethod bb_number-val ((m <Image_BB>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader handsnet_tftrt_yolo-msg:bb_number-val is deprecated.  Use handsnet_tftrt_yolo-msg:bb_number instead.")
  (bb_number m))

(cl:ensure-generic-function 'bb_array-val :lambda-list '(m))
(cl:defmethod bb_array-val ((m <Image_BB>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader handsnet_tftrt_yolo-msg:bb_array-val is deprecated.  Use handsnet_tftrt_yolo-msg:bb_array instead.")
  (bb_array m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Image_BB>) ostream)
  "Serializes a message object of type '<Image_BB>"
  (cl:let* ((signed (cl:slot-value msg 'bb_number)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'bb_array))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'bb_array))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Image_BB>) istream)
  "Deserializes a message object of type '<Image_BB>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'bb_number) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'bb_array) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'bb_array)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'handsnet_tftrt_yolo-msg:BB))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Image_BB>)))
  "Returns string type for a message object of type '<Image_BB>"
  "handsnet_tftrt_yolo/Image_BB")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Image_BB)))
  "Returns string type for a message object of type 'Image_BB"
  "handsnet_tftrt_yolo/Image_BB")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Image_BB>)))
  "Returns md5sum for a message object of type '<Image_BB>"
  "14bc22618fd0092fba3e105e603ce122")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Image_BB)))
  "Returns md5sum for a message object of type 'Image_BB"
  "14bc22618fd0092fba3e105e603ce122")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Image_BB>)))
  "Returns full string definition for message of type '<Image_BB>"
  (cl:format cl:nil "int16 bb_number~%BB[] bb_array~%================================================================================~%MSG: handsnet_tftrt_yolo/BB~%string class~%float32 confidence~%float32[4] coordinates~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Image_BB)))
  "Returns full string definition for message of type 'Image_BB"
  (cl:format cl:nil "int16 bb_number~%BB[] bb_array~%================================================================================~%MSG: handsnet_tftrt_yolo/BB~%string class~%float32 confidence~%float32[4] coordinates~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Image_BB>))
  (cl:+ 0
     2
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'bb_array) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Image_BB>))
  "Converts a ROS message object to a list"
  (cl:list 'Image_BB
    (cl:cons ':bb_number (bb_number msg))
    (cl:cons ':bb_array (bb_array msg))
))
