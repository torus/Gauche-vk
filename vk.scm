;;;
;;; vk
;;;

(define-module vk
  (export test-vk ;; dummy
          aho-aho
          vk-sample-main
          make-vk-sample
          <vk-sample>
          vk-sample-init
          vk-sample-body
          vk-sample-destroy
          <vk-clear-value>
          make-vk-clear-value
          )
  )
(select-module vk)

;; Loads extension
(dynamic-load "vk")

;;
;; Put your Scheme definitions here
;;

