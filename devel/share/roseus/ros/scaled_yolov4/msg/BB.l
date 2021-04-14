;; Auto-generated. Do not edit!


(when (boundp 'scaled_yolov4::BB)
  (if (not (find-package "SCALED_YOLOV4"))
    (make-package "SCALED_YOLOV4"))
  (shadow 'BB (find-package "SCALED_YOLOV4")))
(unless (find-package "SCALED_YOLOV4::BB")
  (make-package "SCALED_YOLOV4::BB"))

(in-package "ROS")
;;//! \htmlinclude BB.msg.html


(defclass scaled_yolov4::BB
  :super ros::object
  :slots (_obj_class _confidence _coordinates ))

(defmethod scaled_yolov4::BB
  (:init
   (&key
    ((:obj_class __obj_class) "")
    ((:confidence __confidence) 0.0)
    ((:coordinates __coordinates) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _obj_class (string __obj_class))
   (setq _confidence (float __confidence))
   (setq _coordinates __coordinates)
   self)
  (:obj_class
   (&optional __obj_class)
   (if __obj_class (setq _obj_class __obj_class)) _obj_class)
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:coordinates
   (&optional __coordinates)
   (if __coordinates (setq _coordinates __coordinates)) _coordinates)
  (:serialization-length
   ()
   (+
    ;; string _obj_class
    4 (length _obj_class)
    ;; float32 _confidence
    4
    ;; float32[] _coordinates
    (* 4    (length _coordinates)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _obj_class
       (write-long (length _obj_class) s) (princ _obj_class s)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _coordinates
     (write-long (length _coordinates) s)
     (dotimes (i (length _coordinates))
       (sys::poke (elt _coordinates i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _obj_class
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _obj_class (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _coordinates
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _coordinates (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _coordinates i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get scaled_yolov4::BB :md5sum-) "dfc87673751af1dddbaefa01947e8324")
(setf (get scaled_yolov4::BB :datatype-) "scaled_yolov4/BB")
(setf (get scaled_yolov4::BB :definition-)
      "string obj_class
float32 confidence
float32[] coordinates
")



(provide :scaled_yolov4/BB "dfc87673751af1dddbaefa01947e8324")


