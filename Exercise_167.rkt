;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; List-of-posn -> number
;; calculate the sum of all x values in a list of posn
(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+ (posn-x (first l)) (sum (rest l)))]))

(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 1 2) (cons (make-posn 1 2) '()))) 2)
(check-expect (sum (cons (make-posn 2 2) (cons (make-posn 3 2) '()))) 5)
(check-expect (sum (cons (make-posn 9 18) (cons (make-posn 2 2) (cons (make-posn 3 2) '())))) 14)

