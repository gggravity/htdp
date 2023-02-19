;; String
;; return the provided string with the first character removed.
;; given:
;;    "Hello world"
;; expected:
;;    "ello world"
(define (string-rest str)
  (substring str 1))

(string-rest "Hello world")
