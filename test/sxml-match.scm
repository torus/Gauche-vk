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

(let ((mat
       (sxml-match
        (lambda (M C)
          (M 'root (C (M 'c1 (lambda (c) (dbg #`"c1 ,(car c)") #t))
                      (M 'c2 (lambda (c) (dbg #`"c2 ,(car c)") #t))
                      (M 'c3 (lambda (c) (dbg #`"c3 ,(car c)") #t)
                         (C (M 'c31 (lambda (c) (dbg #`"c31 ,(car c)") #t))
                            (M 'c32 (lambda (c) (dbg #`"c32 ,(car c)") #t)))))
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
    (dbg sxml)
    (dbg "---\n")

    (test* "positive"  #f (not (mat (cadr sxml))))
    (dbg "\n")
    )


  (dbg (srl:sxml->xml '(root (c1) (c2 (@ (n 1)))
                             (c3 (@ (n 2)) (c31) (c32)))))

  (test* "extra tags"  #f (not (mat '(root (x) (c1) (c2) (c3 (c31) (c32))))))
  (dbg "\n")

  (test* "wrong tag" #f (mat '(root (x)  (c2) (c3 (c31) (c32)))))
  (dbg "\n")
  (test* "wrong tag" #f (mat '(root (c1) (c2) (x (c31) (c32)))))
  (dbg "\n")
  (test* "missing tag" #f (mat '(root (c1)      (c3 (c31) (c32)))))
  (dbg "\n")

  (test* "multiple match"  #f
         (not (mat '(root (c1) (c2 (@ (n 1))) (c2 (@ (n 2)))
                          (c3 (@ (n 1)) (c31) (c32))
                          (c3 (@ (n 2)) (c31) (c32))))))

  )


(display (get-output-string *debug-port*))
