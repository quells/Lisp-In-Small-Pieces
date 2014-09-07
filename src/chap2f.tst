;;; $Id: chap2f.tst,v 4.0 1995/07/10 06:51:04 queinnec Exp $

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

33
   33
xyy 
   *** ; unexistant
'foo
   foo
(if #t 1 2)
   1
(if #f 2 3)
   3
(begin 1 2 3)
   3
(begin (set! a 3) a)
   3
(cons 3 4)
   (3 . 4)
((lambda (x y) (cons x y))
 1 2 )
   (1 . 2)
cons 
   --- ; cons now is a variable
((lambda (f) (f 1 2))
 cons )
   (1 . 2)
(apply (lambda (x y) (cons y x)) '1 '2 '())
   (2 . 1)
((if #t cons list) 1 22)
   (1 . 22)

(bind/de 'x (* 2 3) (lambda () 44))
   44
(bind/de 'x (* 2 3)
    (lambda () 
      (assoc/de 'x (lambda (tag) 'no-tag)) ) )
   6
(bind/de 'x (* 2 3)
    (lambda () 
      (assoc/de 'yyy (lambda (tag) 'no-tag)) ) )
   no-tag

;(bind/de 'x 2
;  (lambda () (+ (assoc/de 'x error) 
;                (let ((x (+ 
;                            (assoc/de 'x error) (assoc/de 'x error) )))
;                  (+ x (assoc/de 'x error)) ) )) )
;  6
(bind/de 'x 2
  (lambda () (+ (assoc/de 'x error) 
                ((lambda (x) (+ x (assoc/de 'x error)))
                 (+ (assoc/de 'x error) (assoc/de 'x error)) ) ) ) )
  8
(bind/de 'x (list 2)
  (lambda () (set-car! (assoc/de 'x error) 3)
             (assoc/de 'x error) ) )
  (3)
(bind/de 'x (list 2)
  (lambda () (set-car! (assoc/de 'x error) 3)
             (car (assoc/de 'x error)) ) )
  3

((lambda (key)
   (bind/de key (* 2 3)
            (lambda ()
              (new-assoc/de key (lambda (tag) 'no-tag) eq?) ) ) )
 '(x) )
   6
((lambda (key)
   (bind/de key (* 2 3)
            (lambda ()
              (new-assoc/de key (lambda (tag) 'no-tag) equal?) ) ) )
 '(x) )
   6
(bind/de '(x) (* 2 3)
         (lambda ()
           (new-assoc/de '(x) (lambda (tag) 'no-tag) eq?) ) )
   no-tag
(bind/de '(x) (* 2 3)
         (lambda ()
           (new-assoc/de '(x) (lambda (tag) 'no-tag) equal?) ) )
   6
;;; same test with a closure instead of a primitive comparator
(bind/de '(x) (* 2 3)
         (lambda ()
           (new-assoc/de '(x) (lambda (tag) 'no-tag) 
                         (lambda (x y) (equal? x y)) ) ) )
   6


;;; end of chap2f.tst
