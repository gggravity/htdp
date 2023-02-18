;; Define the function string-join, which consumes two strings
;; and appends them with "_" in between.

(define (string-join x y)
  (if (and (string? x) (string? y))
      (string-append x "_" y)
      "function require two strings"))

;; (string-join 1234 4331)
(string-join "hello" "world")

