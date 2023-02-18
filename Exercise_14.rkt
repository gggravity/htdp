(define (string-last x)
  (if (string? x) (substring x (- (string-length x) 1) (string-length x)) "Not a string!"))

(string-last "hello world")
;; (string-last 1234)
