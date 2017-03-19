(define-module sxml-match
  (export sxml-match))

(select-module sxml-match)

(use util.match)
(use sxml.ssax)


(define (M tag . procs)
  (define (tag=? children)
    (let ((tagname (caar children)))
      (eq? tagname tag)))

  (lambda (e)
    (let loop ((procs (cons tag=? procs)))
      (if (null? procs)
          #t
          (if ((car procs) e)
              (loop (cdr procs))
              #f)))))

(define (C . procs)
  (define (children e)
    (match e
           ((_ ('@ attr ...) c ...)
            (cddr e))
           ((_  c ...)
            (cdr e))))

  (define (match-any proc children)
    (if (null? children)
        #f
        (if (proc children)
            #t
            (match-any proc (cdr children)))))

  (lambda (e)
    (let loop ((procs procs))
      (if (null? procs)
          #t
          (if (match-any (car procs) (children (car e)))
              (loop (cdr procs))
              #f)))))

(define (sxml-match proc)
  (lambda (e)
    ((proc M C) (list e))))
