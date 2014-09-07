;;; $Id: chap8g.scm,v 4.0 1995/07/10 06:52:06 queinnec Exp $

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

;;; Modification of chap1.scm.
;;; idempotent coding of functions.

(define (invoke fn args)
  (if (procedure? fn)
      (apply fn args)
      (wrong "Not a function" fn) ) ) 

(define (make-function variables body env)
  (lambda values
     (eprogn body (extend env variables values)) ) )

(define-syntax defprimitive 
  (syntax-rules ()
    ((defprimitive name value arity)
     (definitial name 
        (lambda values
          (if (= arity (length values))
              (apply value values)
              (wrong "Incorrect arity"
                     (list 'name values) ) ) ) ) ) ) )

(defprimitive cons cons 2)
(defprimitive car car 1)
(defprimitive cdr cdr 1)
(defpredicate pair? pair? 1)
(defpredicate symbol? symbol? 1)
(defprimitive eq? eq? 2)           ; cf. exercice \ref{exer-predicate}
(defpredicate eq? eq? 2)           ; cf. exercice \ref{exer-predicate}
(defprimitive set-car! set-car! 2)
(defprimitive set-cdr! set-cdr! 2)
(defprimitive + + 2)
(defprimitive - - 2)
(defpredicate = = 2)
(defprimitive < < 2)               ; cf. exercice \ref{exer-predicate}
(defpredicate < < 2)               ; cf. exercice \ref{exer-predicate}
(defpredicate > > 2)
(defprimitive * * 2)
(defpredicate <= <= 2)
(defpredicate >= >= 2)
(defprimitive remainder remainder 2)
(defprimitive display display 1)

(defprimitive call/cc 
  (lambda (f)
    (call/cc (lambda (k)
               (f (lambda values
                    (if (= (length values) 1)
                        (k (car values))
                        (wrong "Incorrect arity" k) ) )) )) )
  1 )

(definitial apply 
  (lambda values
    (if (>= (length values) 2)
        (let ((f (car values))
              (args (let flat ((args (cdr values)))
                      (if (null? (cdr args))
                          (car args)
                          (cons (car args) (flat (cdr args))) ) )) )
        (invoke f args) )
        (wrong "Incorrect arity" 'apply) ) ) )

(definitial list list)

(definitial eval 
  (lambda values
    (if (= (length values) 1)
        (let ((v (car values)))
          (if (program? v)
              (evaluate v env.global)
              (wrong "Illegal program" v) ) )
        (wrong "Incorrect arity" 'eval) ) ) )

;;; end of chap8g.scm
