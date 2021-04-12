
(cl:in-package :asdf)

(defsystem "handsnet_yolo-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "BB" :depends-on ("_package_BB"))
    (:file "_package_BB" :depends-on ("_package"))
    (:file "Image_BB" :depends-on ("_package_Image_BB"))
    (:file "_package_Image_BB" :depends-on ("_package"))
  ))