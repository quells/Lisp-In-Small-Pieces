;;; $Id: chap1d.scm,v 4.1 2006/11/27 14:01:25 queinnec Exp $

;;;(((((((((((((((((((((((((((((((( L i S P ))))))))))))))))))))))))))))))))
;;; This file is derived from the files that accompany the book:
;;;     LISP Implantation Semantique Programmation (InterEditions, France)
;;;     or  Lisp In Small Pieces (Cambridge University Press).
;;; By Christian Queinnec <Christian.Queinnec@INRIA.fr>
;;; The original sources can be downloaded from the author's website at
;;;   http://pagesperso-systeme.lip6.fr/Christian.Queinnec/WWW/LiSP.html
;;; This file may have been altered from the original in order to work with
;;; modern schemes. The latest copy of these altered sources can be found at
;;;   https://github.com/appleby/Lisp-In-Small-Pieces
;;; If you want to report a bug in this program, open a GitHub Issue at the
;;; repo mentioned above.
;;; Check the README file before using this file.
;;;(((((((((((((((((((((((((((((((( L i S P ))))))))))))))))))))))))))))))))

;;;                Variants of exercises for chapter 1.

;(define (tracing.evaluate exp env)
;  (if \ldots \ldots
;      (case (car exp) \ldots
;        (else (let ((fn (evaluate (car e) env))
;                    (arguments (evlis (cdr e) env)) )
;                (display `(calling ,(car e) with . ,arguments) 
;                         *trace-port* )
;                (let ((result (invoke fn arguments)))
;                  (display `(returning from ,(car e) with ,result)
;                           *trace-port* )
;                  result ) )) ) ) ) 

(define (evlis exps env)
  (define (evlis exps)
    ;; (assume (pair? exps))
    (if (pair? (cdr exps))
        (cons (evaluate (car exps) env)
              (evlis (cdr exps)) )
        (list (evaluate (car exps) env)) ) )
  (if (pair? exps)
      (evlis exps)
      '() ) )

(define (extend env names values)
  (cons (cons names values) env) ) 

(define (lookup id env)
  (if (pair? env)
      (let look ((names (caar env))
                 (values (cdar env)) )
         (cond ((symbol? names)
                (if (eq? names id) values 
                    (lookup id (cdr env)) ) )
               ((null? names) (lookup id (cdr env)))
               ((eq? (car names) id) 
                (if (pair? values)
                    (car values)
                    (wrong "Too less values") ) )
               (else (if (pair? values)
                         (look (cdr names) (cdr values))
                         (wrong "Too less values") )) ) )
      (wrong "No such binding" id) ) )

(define (s.make-function variables body env)
  (lambda (values current.env)
     (for-each (lambda (var val)
                 (putprop var 
                          'apval 
                          (cons val (getprop var 'apval)) ) )
               variables values )
     (let ((result (eprogn body current.env)))
        (for-each (lambda (var) 
                    (putprop var 'apval (cdr (getprop var 'apval))) )
                  variables )
        result ) ) )

(define (s.lookup id env)
  (car (getprop id 'apval)) )

(define (s.update! id env value)
  (set-car! (getprop id 'apval) value) )

(define (chapter1d-scheme)
  (define (toplevel)
    (display (evaluate (read) env.global))
    (newline)
    (toplevel) )
  (display "Welcome to Scheme")(newline)
  (call/cc (lambda (end)
             (defprimitive end end 1)
             (toplevel) )) )

;;; end of chap1d.scm
