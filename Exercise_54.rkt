;; Why is (string=? "resting" x) incorrect as the first condition in show?
;;
;; Conversely, formulate a completely accurate condition, that
;; is, a Boolean expression that evaluates to #true precisely when x belongs to the
;; first sub-class of LRCD.

(define (show x)
  (cond
   [(string? x) …]
   [(<= -3 x -1) …]
   [(>= x 0) …]))


;; x and be both a string and a number
(string=? "resting" x)

;; check if x is a string and if true, check if it's eq "resting". 
(and (string? x) (string=? "resting" x))
