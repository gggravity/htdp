;; String
;; produces a string like the given one with the last character removed.
;; given:
;;    "Hello world"
;; expected:
;;    "Hello worl"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

(string-remove-last "Hello world")
