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
  :slots (_class _confidence _coordinates ))

(defmethod handsnet_tftrt_yolo::BB
  (:init
   (&key
    ((:class __class) "")
    ((:confidence __confidence) 0.0)
    ((:coordinates __coordinates) (make-array 4 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _class (string __class))
   (setq _confidence (float __confidence))
   (setq _coordinates __coordinates)
   self)
  (:class
   (&optional __class)
   (if __class (setq _class __class)) _class)
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:coordinates
   (&optional __coordinates)
   (if __coordinates (setq _coordinates __coordinates)) _coordinates)
  (:serialization-length
   ()
   (+
    ;; string _class
    4 (length _class)
    ;; float32 _confidence
    4
    ;; float32[4] _coordinates
    (* 4    4)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _class
       (write-long (length _class) s) (princ _class s)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[4] _coordinates
     (dotimes (i 4)
       (sys::poke (elt _coordinates i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _class
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _class (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[4] _coordinates
   (dotimes (i (length _coordinates))
     (setf (elt _coordinates i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;;
   self)
  )

(setf (get handsnet_tftrt_yolo::BB :md5sum-) "e5df805725a7fa5ef20dff2b5693f3d6")
(setf (get handsnet_tftrt_yolo::BB :datatype-) "handsnet_tftrt_yolo/BB")
(setf (get handsnet_tftrt_yolo::BB :definition-)
      "string class
float32 confidence
float32[4] coordinates
")



(provide :handsnet_tftrt_yolo/BB "e5df805725a7fa5ef20dff2b5693f3d6")


