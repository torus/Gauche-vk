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
          vk-clear-value-color
          vk-clear-value-depth-stencil
          <vk-clear-color-value>
          make-vk-clear-color-value
          <vk-clear-depth-stencil-value>
          )
  )
(select-module vk)

;; Loads extension
(dynamic-load "vk")

;;
;; Put your Scheme definitions here
;;

