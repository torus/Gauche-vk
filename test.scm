;;;
;;; Test vk
;;;

(use gauche.test)

(test-start "vk")
(use vk)
(test-module 'vk)

;; The following is a dummy test code.
;; Replace it for your tests.
(test* "test-vk" "vk is working"
       (test-vk))

(test* "aho-aho" '(a b)
       (aho-aho 'a 'b))

;(vk-sample-main)

;;;;;;;;;;;;;;
(define info #f)
(test* "constructor" #t
       (let ((q (make-vk-sample)))
         (set! info q)
         (is-a? q <vk-sample>)))

(test* "constructor" #t
       (let ((v (make-vk-clear-value)))
         (is-a? v <vk-clear-value>)))


(vk-sample-init info)
(vk-sample-body info)
(vk-sample-destroy info)

;; If you don't want `gosh' to exit with nonzero status even if
;; the test fails, pass #f to :exit-on-failure.
(test-end :exit-on-failure #t)




