;; Auto-generated. Do not edit!


(when (boundp 'scaled_yolov4::Image_BB)
  (if (not (find-package "SCALED_YOLOV4"))
    (make-package "SCALED_YOLOV4"))
  (shadow 'Image_BB (find-package "SCALED_YOLOV4")))
(unless (find-package "SCALED_YOLOV4::IMAGE_BB")
  (make-package "SCALED_YOLOV4::IMAGE_BB"))

(in-package "ROS")
;;//! \htmlinclude Image_BB.msg.html


(defclass scaled_yolov4::Image_BB
  :super ros::object
  :slots (_bb_number _bb_array ))

(defmethod scaled_yolov4::Image_BB
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
    ;; scaled_yolov4/BB[] _bb_array
    (apply #'+ (send-all _bb_array :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _bb_number
       (write-word _bb_number s)
     ;; scaled_yolov4/BB[] _bb_array
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
   ;; scaled_yolov4/BB[] _bb_array
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _bb_array (let (r) (dotimes (i n) (push (instance scaled_yolov4::BB :init) r)) r))
     (dolist (elem- _bb_array)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get scaled_yolov4::Image_BB :md5sum-) "e36224c45647457f9e206d30e8546220")
(setf (get scaled_yolov4::Image_BB :datatype-) "scaled_yolov4/Image_BB")
(setf (get scaled_yolov4::Image_BB :definition-)
      "int16 bb_number
scaled_yolov4/BB[] bb_array
================================================================================
MSG: scaled_yolov4/BB
string obj_class
float32 confidence
float32[] coordinates
")



(provide :scaled_yolov4/Image_BB "e36224c45647457f9e206d30e8546220")


