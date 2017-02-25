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

(define clr-val #f)
(test* "make-vk-clear-value" #t
       (let ((v (make-vk-clear-value)))
         (set! clr-val v)
         (is-a? v <vk-clear-value>)))

(define col-val #f)
(test* "make-vk-clear-color-value" #t
       (let ((v (make-vk-clear-color-value)))
         (set! col-val v)
         (is-a? v <vk-clear-color-value>)))

(define (check-with-tolerance expected result)
  (< (abs (- expected result)) 1.0e-5))

(test* "vk-clear-color-value-float32-set!" 0.1
       (begin (vk-clear-color-value-float32-set! col-val 0 0.1)
              (vk-clear-color-value-float32 col-val 0))
       check-with-tolerance)

(test* "vk-clear-color-value-float32-set!" 0.2
       (begin (vk-clear-color-value-float32-set! col-val 1 0.2)
              (vk-clear-color-value-float32 col-val 1))
       check-with-tolerance)

(test* "vk-clear-color-value-float32-set!" 0.3
       (begin (vk-clear-color-value-float32-set! col-val 2 0.3)
              (vk-clear-color-value-float32 col-val 2))
       check-with-tolerance)

(test* "vk-clear-color-value-float32-set!" 0.4
       (begin (vk-clear-color-value-float32-set! col-val 3 0.4)
              (vk-clear-color-value-float32 col-val 3))
       check-with-tolerance)

(test* "vk-clear-value-color" #t
       (let ((v (vk-clear-value-color clr-val)))
         (is-a? v <vk-clear-color-value>)))

(test* "vk-clear-value-depth-stencil" #t
       (let ((v (vk-clear-value-depth-stencil clr-val)))
         (is-a? v <vk-clear-depth-stencil-value>)))


;; (vk-sample-init info)
;; (vk-sample-body info)
;; (vk-sample-destroy info)

;; If you don't want `gosh' to exit with nonzero status even if
;; the test fails, pass #f to :exit-on-failure.
(test-end :exit-on-failure #t)




