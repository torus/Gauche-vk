;;;
;;; vk
;;;

(define-module vk
  (export test-vk ;; dummy
          aho-aho
          vk-sample-main
          make-vk-sample
          VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO
          VK_SUCCESS
          <vk-sample>
          vk-sample-init
          vk-sample-body
          vk-sample-body-x
          vk-sample-destroy
          vk-sample-device
          <vk-clear-value>
          make-vk-clear-value
          vk-clear-value-color
          vk-clear-value-depth-stencil
          <vk-clear-color-value>
          make-vk-clear-color-value
          vk-clear-color-value-float32
          vk-clear-color-value-float32-set!
          <vk-clear-depth-stencil-value>
          vk-clear-depth-stencil-value-depth-set!
          vk-clear-depth-stencil-value-depth
          vk-clear-depth-stencil-value-stencil-set!
          vk-clear-depth-stencil-value-stencil
          <vk-semaphore-create-info>
          make-vk-semaphore-create-info
          vk-semaphore-create-info-s-type-set!
          vk-semaphore-create-info-s-type
          vk-semaphore-create-info-p-next-set!
          vk-semaphore-create-info-p-next
          vk-semaphore-create-info-flags-set!
          vk-semaphore-create-info-flags
          ;; VkSemaphore
          <vk-semaphore>
          make-vk-semaphore
          vk-create-semaphore
          <vk-device>
          <vk-allocation-callbacks>

          )
  )
(select-module vk)

;; Loads extension
(dynamic-load "vk")

;;
;; Put your Scheme definitions here
;;

