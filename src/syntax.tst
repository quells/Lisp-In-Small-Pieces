;;; $Id: syntax.tst,v 1.3 1994/08/25 17:30:31 queinnec Exp $

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

;;; This is a little test for the port of syntax-caseV2.0. What is tested
;;; is that a compiled syntax-case linked into a Bigloo-based
;;; interpreter is correct. 

;;; test on a predefined syntaxes

(and)
   #t
(and '1)
   1
(and 1 2 3)
   3
(and 1 2 #f 3)
   #f

;;; test on a new syntax

(define-syntax funcall
  (syntax-rules ()
    ((funcall function arguments ...) 
     (function arguments ...) ) ) )
   ---
(let ((f (lambda (x) (funcall cons x x))))
  (funcall f (+ 2 3)) )
   (5 . 5)

;;; expand.ss seems to be false on a non-symbol as first argument of define.
;;; I patched expand.ss and rebuild expand.bb so it is good now.

(begin (define a 33) a)
   33
(begin (define (a) 22) (a))
   22
(begin (define (a . x) (cons x 2)) (a 0 1))
   ((0 1) . 2)

;;; This seems to pose problems. In fact the problem was that
;;; chap*.scm contains calls to load (the Bigloo load) that does not
;;; call syntax-expand. So they are useless but "always keep tests!"

(define env.global '())
   ---
(define-syntax definitial 
  (syntax-rules ()
    ((definitial name)
     (begin (set! env.global (cons (cons 'name 'void) env.global))
            'name ) )
    ((definitial name value)
     (begin (set! env.global (cons (cons 'name value) env.global))
            'name ) ) ) )
   ---
(definitial t #t)
   ---
env.global
   ((t . #t)) 

;;; Testing define-abbreviation.

(define-abbreviation (foo a b)
  `(quote (,a foo ,b)) )
   ---
(foo 2 3) 
   (2 foo 3)
(foo (+ 1 2) 3)
   ((+ 1 2) foo 3)

;;; test that when and unless are present.

(when (pair? (cons 'a 'b)) 1 2)
   2
(when #f 1 2)
   ---
(unless (pair? (cons 'a 'b)) 1 2)
   ---
(unless #f 1 2 3)
   3

;;; Some additional functions are required
(atom? 'foo) 
   #t
(atom? (cons 1 2))
   #f
(get-internal-run-time)
   ---
(number? (get-internal-run-time))
   #t
(iota 0 4)
   (0 1 2 3)
(putprop 'foo 'bar 'hux)
   ---
(getprop 'foo 'bar)
   hux

"		Successful end of tests.	"
   ---

;;; end of syntax.tst
