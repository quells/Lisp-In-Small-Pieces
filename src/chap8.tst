;;; $Id: chap8.tst,v 4.0 1995/07/10 06:51:58 queinnec Exp $

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

;;; Testing programs and quotations

(program? 'x)
   #t
(program? 3)
   #t
(program? "foo")
   #t
(program? #\c)
   #t
(program? #f)
   #t
(program? #t)
   #t
(program? car)
   #f
(call/cc (lambda (k) (program? k)))
   #f
(program? '(if 1 2 3))
   #t
(program? '(if))
   #f
(program? '(if 1))
   #f
(program? '(if . 1))
   #f
(program? '(if 1 2))
   #f
(program? '(if 1 2 . 3))
   #f
(program? '(if 1 2 3 . 4))
   #f
(program? '(if 1 2 3 4))
   #f
(program? '(begin))
   #f
(program? '(begin 1))
   #t
(program? '(begin 1 2 3 4 5))
   #t
(program? '(begin . 1))
   #f
(program? '(begin 1 . 2))
   #f
(program? '(set! 1 2))
   #f
(program? '(set! a 1))
   #t
(program? '(set! a 2 3))
   #f
(program? '(set! a . 1))
   #f
(program? '())
   #f
(program? '(1))
   #t
(program? '(1 . 2))
   #f
(program? '(1 2 3))
   #t
(program? '(1 2 3 . 4))
   #f
(program? '(lambda () 1))
   #t
(program? '(lambda () 1 .  2))
   #f
(program? '(lambda () 1 2 3 4))
   #t
(program? '(lambda ()))
   #f
(program? '(lambda a 1))
   #t
(program? '(lambda (a b) a))
   #t
(program? '(lambda (a b c b) 2))
   #f
(program? '(lambda (a b c . a) 22))
   #f
(program? '(quote))
   #f
(program? '(quote . 1))
   #f
(program? '(quote 1 2))
   #f
(program? '(quote 1))
   #t
(program? (let* ((a '(quote 1))
                 (b (list a a)) )
            b ))
   #t
(program? (let* ((a '(quote 1))
                 (b (list a a)) )
            (set-car! b b)
            b ))
   #f
(program? (let* ((a* '(a b c)))
            (set-cdr! (cddr a*) a*)
            `(begin . ,a*) ))
   #f

(quotation? 'a)
    #t
(quotation? 3)
   #t
(quotation? "foo")
   #t
(quotation? #\newline)
   #t
(quotation? #f)
   #t
(quotation? #t)
   #t
(call/cc quotation?)
   #f
(quotation? quotation?)
   #f
(quotation? '(a b c))
   #t
(quotation? '(a b . c))
   #t
(quotation? '#(a b))
   #t
(let* ((a '#(1 2 3))
       (b (list a a)) )
  (vector-set! a 1 b)
  (quotation? a) )
   #f

;;; end of chap8.tst
