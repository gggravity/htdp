;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; NEList-of-temperatures -> Number
;; computes the average temperature
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

;; List-of-temperatures -> Number
;; adds up the temperatures on the given list
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

;; List-of-temperatures -> Number
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ (how-many (rest alot)) 1)]))

(check-error (average '())  "/: division by zero")

(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)

(check-expect (average (cons 4 (cons 6 (cons 3 (cons 3 (cons 4 '())))))) 4)
