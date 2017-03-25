(use gauche.test)
(use sxml.serializer)
(use sxml.ssax)

(test-start "sxml-match")
(use sxml-match)
(test-module 'sxml-match)

((sxml-match (lambda (M C C*) (M 'a))) '(a))

(test* "single tag" '(a) ((sxml-match (lambda (M C C*) (M 'a))) '(a)))
(test* "single tag with attributes" '(a (@ (n "1")))
       ((sxml-match (lambda (M C C*) (M 'a))) '(a (@ (n "1")))))

(let ((mat
       (sxml-match
        (lambda (M C C*)
          (M 'root (C (M 'c1)
                      (M 'c2)
                      (M 'c3
                         (C (M 'c31)
                            (M 'c32))))
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

  (test* "multiple match"
         '(root (c1 (c2 (@ (n "1")) (c3 (@ (m "1"))))
                    (c2 (@ (n "2")) (c3 (@ (m "2"))))
                    (c2 (@ (n "3")) (c3 (@ (m "3"))))))
         (let ((doc '(root (c1 (c2 (@ (n "1")) (c3 (@ (m "1"))))
                               (c2 (@ (n "2")) (c3 (@ (m "2"))))
                               (c2 (@ (n "3")) (c3 (@ (m "3")) (c4))))))
               (mat
                (sxml-match
                 (lambda (M C C*)
                   (M 'root (C (M 'c1
                                  (C* (M 'c2
                                         (C (M 'c3)))))))))))
           (mat doc)
           ))

  (test* "multiple multiple match" '(root (c1 (c2 (@ (n "1")) (c3 (@ (m "1"))))
                                              (c4 (@ (n "1")))
                                              (c2 (@ (n "2")) (c3 (@ (m "2"))))
                                              (c4 (@ (n "2")))
                                              (c2 (@ (n "3")) (c3 (@ (m "3"))))))
         (let ((doc '(root (c1 (c2 (@ (n "1")) (c3 (@ (m "1"))))
                               (c4 (@ (n "1")))
                               (c2 (@ (n "2")) (c3 (@ (m "2"))))
                               (c5)
                               (c4 (@ (n "2")))
                               (c5)
                               (c2 (@ (n "3")) (c3 (@ (m "3")))))))
               (mat
                (sxml-match
                 (lambda (M C C*)
                   (M 'root (C (M 'c1
                                  (C* (M 'c2
                                         (C (M 'c3)))
                                      (M 'c4)))))))))
           (mat doc)
           ))
  )

(test-end)
