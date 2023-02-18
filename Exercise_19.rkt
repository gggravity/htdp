;; Define the function string-insert, which consumes a string
;; str plus a number i and inserts "_" at the ith position of str. Assume i is a
;; number between 0 and the length of the given string (inclusive). See exercise 3
;; for ideas. Ponder how string-insert copes with "".

(define (string-insert str number)
  (if (and (string? str) (number? number) (> (string-length str) 0) (> (string-length str) number))
      (string-append (substring str 0 number) "_" (substring str (+ number 1) (string-length str)))
      "function require a non empty string and a number not larger then the length of the string"))

;; (string-insert 1234 4331)
(string-insert "hello" 4)

