(require test-engine/racket-tests)

(define normal-tax 1000)
(define luxury-tax 10000)

(define normal-tax-pct 0.05)
(define luxury-tax-pct 0.08)

;; Price -> Number
;; computes the amount of tax charged for p

(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))

(define (sales-tax p)
  (cond
   [(and (<= 0 p) (< p  normal-tax)) 0]
   [(and (<=  normal-tax p) (< p luxury-tax)) (* normal-tax-pct p)]
   [(>= p luxury-tax) (* luxury-tax-pct p)]))
