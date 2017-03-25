(use gauche.test)
(use sxml.serializer)
(use sxml.ssax)

(test-start "sxml-match")
(use sxml-match)
(test-module 'sxml-match)

(define *debug-port* (open-output-string))
(define (dbg . rest)
  (with-output-to-port *debug-port*
    (lambda ()
      (apply print rest))))


((sxml-match (lambda (M C) (M 'a))) '(a))

(test* "single tag" '(a) ((sxml-match (lambda (M C) (M 'a))) '(a)))
(test* "single tag with attributes" '(a (@ (n "1")))
       ((sxml-match (lambda (M C) (M 'a))) '(a (@ (n "1")))))

(let ((mat
       (sxml-match
        (lambda (M C)
          (dbg "----")
          (M 'root (C (M 'c1 (lambda (c) (dbg #`"c1 ,(car c)") ()))
                      (M 'c2 (lambda (c) (dbg #`"c2 ,(car c)") ()))
                      (M 'c3 (lambda (c) (dbg #`"c3 ,(car c)") ())
                         (C (M 'c31 (lambda (c) (dbg #`"c31 ,(car c)") ()))
                            (M 'c32 (lambda (c) (dbg #`"c32 ,(car c)") ())))))
             )))))

  (let* ((xml (string-append
               "<root>"
               "  <c1/>"
               "  <c2 n=\"1\"/>"
               "  <c3 n=\"2\">"
               "    <c31/>"
               "    <c32/>"
               "  </c3>"
               "</root>"))
         (sxml (ssax:xml->sxml (open-input-string xml) ())))

    (test* "positive" '(root (c1) (c2 (@ (n "1"))) (c3 (@ (n "2")) (c31) (c32)))
           (mat (cadr sxml))))

  (test* "extra tags" '(root (c1) (c2) (c3 (c31) (c32)))
         (mat '(root (x) (c1) (c2) (c3 (c31) (c32)))))

  (test* "fails when a wrong element" #f (mat '(root (x)  (c2) (c3 (c31) (c32)))))
  (test* "fails when a wrong element" #f (mat '(root (c1) (c2) (x (c31) (c32)))))
  (test* "fails when a element is missing" #f (mat '(root (c1) (c3 (c31) (c32)))))

  (test* "ignores extra elements"  '(root (c1) (c2 (@ (n "1"))) (c3 (@ (n "1")) (c31) (c32)))
         (mat '(root (c1) (c2 (@ (n "1"))) (c2 (@ (n "2")))
                     (c3 (@ (n "1")) (c31) (c32))
                     (c3 (@ (n "2")) (c31) (c32)))))
  )


;(display (get-output-string *debug-port*))
