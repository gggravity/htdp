;; String
;; return the first character in a string
;; given:
;;    "Hello world"
;; expected:
;;    "H"
(define (string-first str)
  (substring str 0 1))

(string-first "Hello world")
