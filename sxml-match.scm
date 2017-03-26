(define-module sxml-match
  (export sxml-match))

(select-module sxml-match)

(use util.match)
(use sxml.ssax)
(use sxml.tools)

(define (children e)
  (sxml:content-raw e))

(define (isolate-element e) ;; FIXME: ignores aux-list
  (match e
         ((_ ('@ attr ...) c ...)
          (take e 2))
         ((_  c ...)
          (take e 1))))

(define (test-condition proc elem)
  (let ((result (proc elem)))
    (if (eq? #t result)
        ()
        result)))

(define (M tag . procs)
  (define (tag=? elem)
    (let ((tagname (sxml:name elem)))
      (eq? tagname tag)))

  (lambda (elem)
    (let loop ((procs (cons tag=? procs)) (children ()))
      (if (null? procs)
          (append (isolate-element elem) (reverse children))
          (let ((result (test-condition (car procs) elem)))
            (if result
                (loop (cdr procs) (append result children))
                #f))))))

(define (C . procs)
  (define (match-any proc children)
    (if (null? children)
        #f
        (let ((result (test-condition proc (car children))))
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
        (let ((result (test-condition (car procs) child)))
          (if result
              result
              (match-any (cdr procs) child)))))
  (lambda (e)
    (let loop ((children (children e))
               (elems ()))
      (if (null? children)
          elems
          (let ((matched (match-any procs (car children))))
            (if matched
                (loop (cdr children) (cons matched elems))
                (loop (cdr children) elems)))))))

(define (sxml-match proc)
  (lambda (e)
    ((proc M C C*) e)))
