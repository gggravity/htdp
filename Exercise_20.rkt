;; Define the function string-delete, which consumes a string
;; plus a number i and deletes the ith position from str. Assume i is a number
;; between 0 (inclusive) and the length of the given string (exclusive). See exercise
;; 4 for ideas. Can string-delete deal with empty strings?


(define (string-delete str num)
  (if (and (string? str) (number? num) (> (string-length str) 0) (> (string-length str) num))
      (string-append (substring str 0 num) (substring str (+ num 1) (string-length str)))
      "function require a non empty string and a number not larger then the length of the string"))


(string-delete "hello world" 6)

