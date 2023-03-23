;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; NEList-of-temperatures -> Number
;; adds up the temperatures on the given list
(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]))

(check-error (sum '())  "rest: expects a non-empty list; given: '()")
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (sum (cons 4 (cons 6 (cons 3 (cons 3 (cons 4 '())))))) 20)

;; NEList-of-temperatures -> Number
(define (how-many ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else (+ (how-many (rest ne-l)) 1)]))

(check-error (how-many '())  "rest: expects a non-empty list; given: '()")
(check-expect (how-many (cons 1 '())) 1)
(check-expect (how-many (cons 1 (cons 2 (cons 3 '())))) 3)
(check-expect (how-many (cons 4 (cons 6 (cons 3 (cons 3 (cons 4 '())))))) 5)

;; NEList-of-temperatures -> Number
;; computes the average temperature
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

(check-error (average '())  "rest: expects a non-empty list; given: '()")
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-expect (average (cons 4 (cons 6 (cons 3 (cons 3 (cons 4 '())))))) 4)


