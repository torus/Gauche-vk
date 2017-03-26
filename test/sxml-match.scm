(use gauche.test)
(use sxml.serializer)
(use sxml.ssax)
(use sxml.tools)

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

(define *xml*
  (string-append
   "<cdecl id=\"231565\" addr=\"0x7f547fd3a2b0\" >"
   "    <attributelist id=\"231566\" addr=\"0x7f547fd3a2b0\" >"
   "        <attribute name=\"sym_name\" value=\"vkAcquireNextImageKHR\" id=\"231567\" addr=\"0x7f547fcc01b0\" />"
   "        <attribute name=\"name\" value=\"vkAcquireNextImageKHR\" id=\"231568\" addr=\"0x7f547fcc01b0\" />"
   "        <attribute name=\"decl\" value=\"f(VkDevice,VkSwapchainKHR,uint64_t,VkSemaphore,VkFence,p.uint32_t).\" id=\"231569\" addr=\"0x7f547fcc01b0\" />"
   "        <parmlist id=\"231570\" addr=\"0x7f547fd39c50\" >"
   "            <parm id=\"231571\">"
   "                <attributelist id=\"231572\" addr=\"0x7f547fd39c50\" >"
   "                    <attribute name=\"name\" value=\"device\" id=\"231573\" addr=\"0x7f547fcc01b0\" />"
   "                    <attribute name=\"type\" value=\"VkDevice\" id=\"231574\" addr=\"0x7f547fcc01b0\" />"
   "                    <attribute name=\"compactdefargs\" value=\"1\" id=\"231575\" addr=\"0x7f547fcc01b0\" />"
   "                </attributelist >"
   "            </parm >"
   "            <parm id=\"231576\">"
   "                <attributelist id=\"231577\" addr=\"0x7f547fd39d70\" >"
   "                    <attribute name=\"name\" value=\"swapchain\" id=\"231578\" addr=\"0x7f547fcc01b0\" />"
   "                    <attribute name=\"type\" value=\"VkSwapchainKHR\" id=\"231579\" addr=\"0x7f547fcc01b0\" />"
   "                </attributelist >"
   "            </parm >"
   "            <parm id=\"231580\">"
   "                <attributelist id=\"231581\" addr=\"0x7f547fd39e90\" >"
   "                    <attribute name=\"name\" value=\"timeout\" id=\"231582\" addr=\"0x7f547fcc01b0\" />"
   "                    <attribute name=\"type\" value=\"uint64_t\" id=\"231583\" addr=\"0x7f547fcc01b0\" />"
   "                </attributelist >"
   "            </parm >"
   "            <parm id=\"231584\">"
   "                <attributelist id=\"231585\" addr=\"0x7f547fd39fb0\" >"
   "                    <attribute name=\"name\" value=\"semaphore\" id=\"231586\" addr=\"0x7f547fcc01b0\" />"
   "                    <attribute name=\"type\" value=\"VkSemaphore\" id=\"231587\" addr=\"0x7f547fcc01b0\" />"
   "                </attributelist >"
   "            </parm >"
   "            <parm id=\"231588\">"
   "                <attributelist id=\"231589\" addr=\"0x7f547fd3a0d0\" >"
   "                    <attribute name=\"name\" value=\"fence\" id=\"231590\" addr=\"0x7f547fcc01b0\" />"
   "                    <attribute name=\"type\" value=\"VkFence\" id=\"231591\" addr=\"0x7f547fcc01b0\" />"
   "                </attributelist >"
   "            </parm >"
   "            <parm id=\"231592\">"
   "                <attributelist id=\"231593\" addr=\"0x7f547fd3a1f0\" >"
   "                    <attribute name=\"name\" value=\"pImageIndex\" id=\"231594\" addr=\"0x7f547fcc01b0\" />"
   "                    <attribute name=\"type\" value=\"p.uint32_t\" id=\"231595\" addr=\"0x7f547fcc01b0\" />"
   "                </attributelist >"
   "            </parm >"
   "        </parmlist >"
   "        <attribute name=\"kind\" value=\"function\" id=\"231596\" addr=\"0x7f547fcc01b0\" />"
   "        <attribute name=\"type\" value=\"VkResult\" id=\"231597\" addr=\"0x7f547fcc01b0\" />"
   "        <attribute name=\"sym_symtab\" value=\"0x7f5480fe18b0\" id=\"231598\" addr=\"0x7f5480fe18b0\" />"
   "        <attribute name=\"sym_overname\" value=\"__SWIG_0\" id=\"231599\" addr=\"0x7f547fcc01b0\" />"
   "    </attributelist >"
   "</cdecl >"))

(let ((mat (sxml-match
            (lambda (M C C*)
              (M 'cdecl (C (M 'attributelist
                              (C (M 'attribute (lambda (e) (string=? "name" (sxml:attr e 'name))))
                                 (M 'attribute (lambda (e) (string=? "kind" (sxml:attr e 'name))))
                                 (M 'attribute (lambda (e) (string=? "type" (sxml:attr e 'name))))
                                 (M 'parmlist
                                    (C* (M 'parm (C (M 'attributelist (C* (M 'attribute)))))))
                                 )))
                 )))))

  (test* "test attributes"
         '(cdecl (@ (id "231565") (addr "0x7f547fd3a2b0"))
                 (attributelist (@ (id "231566") (addr "0x7f547fd3a2b0"))
                                (attribute (@ (value "vkAcquireNextImageKHR") (name "name") (id "231568") (addr "0x7f547fcc01b0")))
                                (attribute (@ (value "function") (name "kind") (id "231596") (addr "0x7f547fcc01b0")))
                                (attribute (@ (value "VkResult") (name "type") (id "231597") (addr "0x7f547fcc01b0")))
                                (parmlist (@ (id "231570") (addr "0x7f547fd39c50"))
                                          (parm (@ (id "231571"))
                                                (attributelist (@ (id "231572") (addr "0x7f547fd39c50"))
                                                               (attribute (@ (value "device") (name "name") (id "231573") (addr "0x7f547fcc01b0")))
                                                               (attribute (@ (value "VkDevice") (name "type") (id "231574") (addr "0x7f547fcc01b0")))
                                                               (attribute (@ (value "1") (name "compactdefargs") (id "231575") (addr "0x7f547fcc01b0")))))
                                          (parm (@ (id "231576"))
                                                (attributelist (@ (id "231577") (addr "0x7f547fd39d70"))
                                                               (attribute (@ (value "swapchain") (name "name") (id "231578") (addr "0x7f547fcc01b0")))
                                                               (attribute (@ (value "VkSwapchainKHR") (name "type") (id "231579") (addr "0x7f547fcc01b0")))))
                                          (parm (@ (id "231580"))
                                                (attributelist (@ (id "231581") (addr "0x7f547fd39e90"))
                                                               (attribute (@ (value "timeout") (name "name") (id "231582") (addr "0x7f547fcc01b0")))
                                                               (attribute (@ (value "uint64_t") (name "type") (id "231583") (addr "0x7f547fcc01b0")))))
                                          (parm (@ (id "231584"))
                                                (attributelist (@ (id "231585") (addr "0x7f547fd39fb0"))
                                                               (attribute (@ (value "semaphore") (name "name") (id "231586") (addr "0x7f547fcc01b0")))
                                                               (attribute (@ (value "VkSemaphore") (name "type") (id "231587") (addr "0x7f547fcc01b0")))))
                                          (parm (@ (id "231588"))
                                                (attributelist (@ (id "231589") (addr "0x7f547fd3a0d0"))
                                                               (attribute (@ (value "fence") (name "name") (id "231590") (addr "0x7f547fcc01b0")))
                                                               (attribute (@ (value "VkFence") (name "type") (id "231591") (addr "0x7f547fcc01b0")))))
                                          (parm (@ (id "231592"))
                                                (attributelist (@ (id "231593") (addr "0x7f547fd3a1f0"))
                                                               (attribute (@ (value "pImageIndex") (name "name") (id "231594") (addr "0x7f547fcc01b0")))
                                                               (attribute (@ (value "p.uint32_t") (name "type") (id "231595") (addr "0x7f547fcc01b0"))))))))
         (mat (cadr (ssax:xml->sxml (open-input-string *xml*) ()))))

  )


(test-end)
