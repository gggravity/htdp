;; String
;; return the last character in a string
;; given:
;;    "Hello world"
;; expected:
;;    "d"
(define (string-last str)
  (substring str (- (string-length str) 1)))

(string-last "Hello world")
