;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define pay_pr_hour 100)

;; Number -> Number
;; computes the wage for h hours of work
(define (wage h)
  (* pay_pr_hour h))

;; List-of-numbers -> List-of-numbers
;; computes the weekly wages for teh weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [(>= (first whrs) 100) (error "long working hours detected")]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (wage 28)  '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (wage 4) (cons (wage 2) '())))
(check-error (wage* (cons 128 '())) "long working hours detected") 
(check-error (wage* (cons 4 (cons 222 '()))) "long working hours detected") 
