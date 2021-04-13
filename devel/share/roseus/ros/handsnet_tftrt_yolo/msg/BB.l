;; Auto-generated. Do not edit!


(when (boundp 'handsnet_tftrt_yolo::BB)
  (if (not (find-package "HANDSNET_TFTRT_YOLO"))
    (make-package "HANDSNET_TFTRT_YOLO"))
  (shadow 'BB (find-package "HANDSNET_TFTRT_YOLO")))
(unless (find-package "HANDSNET_TFTRT_YOLO::BB")
  (make-package "HANDSNET_TFTRT_YOLO::BB"))

(in-package "ROS")
;;//! \htmlinclude BB.msg.html


(defclass handsnet_tftrt_yolo::BB
  :super ros::object
  :slots (_obj_class _confidence _coordinates ))

(defmethod handsnet_tftrt_yolo::BB
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

(setf (get handsnet_tftrt_yolo::BB :md5sum-) "dfc87673751af1dddbaefa01947e8324")
(setf (get handsnet_tftrt_yolo::BB :datatype-) "handsnet_tftrt_yolo/BB")
(setf (get handsnet_tftrt_yolo::BB :definition-)
      "string obj_class
float32 confidence
float32[] coordinates
")



(provide :handsnet_tftrt_yolo/BB "dfc87673751af1dddbaefa01947e8324")


