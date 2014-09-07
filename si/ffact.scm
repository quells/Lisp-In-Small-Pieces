;;; $Id$

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

;;; (compile-file "si/ffact")
;;; (run-application "si/ffact")
;;; (disassemble *code*)

((lambda (fact) (fact 5 fact (lambda (x) x)))
 (lambda (n f k) (if (= n 0) (k 1) (f (- n 1) f (lambda (r) (k (* n r)))))) )

;;; Code:
;((NON-CONT-ERR)
; (FINISH)
; (RESTAURE-ENV)
; (RETURN)
;
; (CREATE-CLOSURE)
; (SHORT-GOTO 59)
;
; (ARITY=?4)                             ; (lambda (n f k) \ldots)
; (EXTEND-ENV)
; (SHALLOW-ARGUMENT-REF0)
; (PUSH-VALUE)
; (CONSTANT0)
; (POP-ARG1)
; (CALL2-=)
; (SHORT-JUMP-FALSE 10)
; (SHALLOW-ARGUMENT-REF2)
; (PUSH-VALUE)
; (CONSTANT1)
; (PUSH-VALUE)
; (ALLOCATE-FRAME2)
; (POP-FRAME!0)
; (POP-FUNCTION)
; (FUNCTION-GOTO)
; (SHORT-GOTO 39)
; (SHALLOW-ARGUMENT-REF1)
; (PUSH-VALUE)
; (SHALLOW-ARGUMENT-REF0)
; (PUSH-VALUE)
; (CONSTANT1)
; (POP-ARG1)
; (CALL2--)
; (PUSH-VALUE)
; (SHALLOW-ARGUMENT-REF1)
; (PUSH-VALUE)
; (CREATE-CLOSURE)
; (SHORT-GOTO 19)
;
; (ARITY=?2)                             ; (lambda (r) (k (* n r)))
; (EXTEND-ENV)
; (DEEP-ARGUMENT-REF 1 2)
; (PUSH-VALUE)
; (DEEP-ARGUMENT-REF 1 0)
; (PUSH-VALUE)
; (SHALLOW-ARGUMENT-REF0)
; (POP-ARG1)
; (CALL2-*)
; (PUSH-VALUE)
; (ALLOCATE-FRAME2)
; (POP-FRAME!0)
; (POP-FUNCTION)
; (FUNCTION-GOTO)
; (RETURN)
;
; (PUSH-VALUE)
; (ALLOCATE-FRAME4)
; (POP-FRAME!2)
; (POP-FRAME!1)
; (POP-FRAME!0)
; (POP-FUNCTION)
; (FUNCTION-GOTO)
; (RETURN)
;
; (PUSH-VALUE)
; (ALLOCATE-FRAME2)
; (POP-FRAME!0)
; (EXTEND-ENV)
; (SHALLOW-ARGUMENT-REF0)
; (PUSH-VALUE)
; (SHORT-NUMBER 5)
; (PUSH-VALUE)
; (SHALLOW-ARGUMENT-REF0)
; (PUSH-VALUE)
; (CREATE-CLOSURE)
; (SHORT-GOTO 4)
;
; (ARITY=?2)                             ; (lambda (x) x)
; (EXTEND-ENV)
; (SHALLOW-ARGUMENT-REF0)
; (RETURN)
;
; (PUSH-VALUE)
; (ALLOCATE-FRAME4)
; (POP-FRAME!2)
; (POP-FRAME!1)
; (POP-FRAME!0)
; (POP-FUNCTION)
; (FUNCTION-GOTO)
; (RETURN)
; )

;;; end of ffact.scm
