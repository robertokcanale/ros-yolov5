;; Auto-generated. Do not edit!


(when (boundp 'handsnet_tftrt_yolo::Image_BB)
  (if (not (find-package "HANDSNET_TFTRT_YOLO"))
    (make-package "HANDSNET_TFTRT_YOLO"))
  (shadow 'Image_BB (find-package "HANDSNET_TFTRT_YOLO")))
(unless (find-package "HANDSNET_TFTRT_YOLO::IMAGE_BB")
  (make-package "HANDSNET_TFTRT_YOLO::IMAGE_BB"))

(in-package "ROS")
;;//! \htmlinclude Image_BB.msg.html


(defclass handsnet_tftrt_yolo::Image_BB
  :super ros::object
  :slots (_bb_number _bb_array ))

(defmethod handsnet_tftrt_yolo::Image_BB
  (:init
   (&key
    ((:bb_number __bb_number) 0)
    ((:bb_array __bb_array) ())
    )
   (send-super :init)
   (setq _bb_number (round __bb_number))
   (setq _bb_array __bb_array)
   self)
  (:bb_number
   (&optional __bb_number)
   (if __bb_number (setq _bb_number __bb_number)) _bb_number)
  (:bb_array
   (&rest __bb_array)
   (if (keywordp (car __bb_array))
       (send* _bb_array __bb_array)
     (progn
       (if __bb_array (setq _bb_array (car __bb_array)))
       _bb_array)))
  (:serialization-length
   ()
   (+
    ;; int16 _bb_number
    2
    ;; handsnet_tftrt_yolo/BB[] _bb_array
    (apply #'+ (send-all _bb_array :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _bb_number
       (write-word _bb_number s)
     ;; handsnet_tftrt_yolo/BB[] _bb_array
     (write-long (length _bb_array) s)
     (dolist (elem _bb_array)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _bb_number
     (setq _bb_number (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; handsnet_tftrt_yolo/BB[] _bb_array
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _bb_array (let (r) (dotimes (i n) (push (instance handsnet_tftrt_yolo::BB :init) r)) r))
     (dolist (elem- _bb_array)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get handsnet_tftrt_yolo::Image_BB :md5sum-) "e36224c45647457f9e206d30e8546220")
(setf (get handsnet_tftrt_yolo::Image_BB :datatype-) "handsnet_tftrt_yolo/Image_BB")
(setf (get handsnet_tftrt_yolo::Image_BB :definition-)
      "int16 bb_number
handsnet_tftrt_yolo/BB[] bb_array
================================================================================
MSG: handsnet_tftrt_yolo/BB
string obj_class
float32 confidence
float32[] coordinates
")



(provide :handsnet_tftrt_yolo/Image_BB "e36224c45647457f9e206d30e8546220")


