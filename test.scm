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

;; If you don't want `gosh' to exit with nonzero status even if
;; the test fails, pass #f to :exit-on-failure.
(test-end :exit-on-failure #t)




