(define-module sxml-match
  (export sxml-match))

(select-module sxml-match)

(use util.match)
(use sxml.ssax)
(use sxml.tools)

(define (children e)
  (sxml:content-raw e))

(define (test-condition proc elem previous-results)
  (let ((result (if (procedure-arity-includes? proc 2)
                    (proc elem previous-results)
                    (proc elem))))
    (if (eq? #t result)
        ()
        result)))

(define (M tag . procs)
  (define (tag=? elem)
    (let ((tagname (sxml:name elem)))
      (eq? tagname tag)))

  (lambda (elem)
    (let loop ((procs (cons tag=? procs)) (results ()))
      (if (null? procs)
          #;(append (isolate-element elem) (reverse results))
          (reverse results)
          (let* ((proc (car procs))
                 (result (test-condition proc elem results)))
            (if result
                (loop (cdr procs) (append result results))
                #f))))))

(define (C . procs)
  (define (match-any proc children)
    (if (null? children)
        #f
        (let ((result (test-condition proc (car children) ())))
          (if result
              result
              (match-any proc (cdr children))))))

  (lambda (e)
    (let loop ((procs procs) (elems ()))
      (if (null? procs)
          elems
          (let ((matched (match-any (car procs) (children e))))
            (if matched
                (loop (cdr procs) (cons matched elems))
                #f))))))

(define (C* . procs)
  (define (match-any procs child)
    (if (null? procs)
        #f
        (let ((result (test-condition (car procs) child ())))
          (if result
              result
              (match-any (cdr procs) child)))))
  (lambda (e)
    (let loop ((children (children e))
               (elems ()))
      (if (null? children)
          (reverse elems)
          (let ((matched (match-any procs (car children))))
            (if matched
                (loop (cdr children) (cons matched elems))
                (loop (cdr children) elems)))))))

(define (sxml-match proc)
  (lambda (e)
    ((proc M C C*) e)))
