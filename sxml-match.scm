(define-module sxml-match
  (export sxml-match))

(select-module sxml-match)

(use util.match)
(use sxml.ssax)


(define (children e)
  (match e
         ((_ ('@ attr ...) c ...)
          (cddr e))
         ((_  c ...)
          (cdr e))))

(define (element e)
  (match e
         ((_ ('@ attr ...) c ...)
          (take e 2))
         ((_  c ...)
          (take e 1))))

(define (M tag . procs)
  (define (tag=? children)
    (let ((tagname (caar children)))
      (if (eq? tagname tag)
          ()
          #f)))

  (lambda (elems)
    (let loop ((procs (cons tag=? procs)) (children ()))
      (if (null? procs)
          (append (element (car elems)) (reverse children))
          (let ((result ((car procs) elems)))
            (if result
                (loop (cdr procs) (append result children))
                #f))))))

(define (C . procs)
  (define (match-any proc children)
    (if (null? children)
        #f
        (let ((result (proc children)))
          (if result
              result
              (match-any proc (cdr children))))))

  (lambda (e)
    (let loop ((procs procs) (elems ()))
      (if (null? procs)
          elems
          (let ((matched (match-any (car procs) (children (car e)))))
            (if matched
                (loop (cdr procs) (cons matched elems))
                #f))))))

(define (sxml-match proc)
  (lambda (e)
    ((proc M C) (list e))))
