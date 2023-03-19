;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(define-struct vec [x y])
;; A vec is
;;   (make-vec PositiveNumber PositiveNumber)
;; interpretation represents a velocity vector

(define (checked-vec x y)
  (cond
    [(and (number? x)
          (number? y)
          (>= x 0)
          (>= y 0))
     (make-vec x y)]
    [else (error "vec: x or y are not a PositiveNumer")]))

(check-expect (checked-vec 0 0) (make-vec 0 0))
(check-expect (checked-vec 1 1) (make-vec 1 1))
(check-expect (checked-vec 12 12) (make-vec 12 12))

(checked-vec -1 1)
