;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct ball [x y speed-x speed-y])

(number? (make-ball 1 2 3 4)) ; ok, #false

(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3)) ; ok, 3 

(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3)) ; ok, 6

;; (ball-x (make-posn 1 2)) ; error

;; (ball-speed-y 5) ; error
