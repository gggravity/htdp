(define (string-first x)
  (if (string? x) (substring x 0 1) "Not a string!"))

(string-first "hello world")
(string-first 1234)
