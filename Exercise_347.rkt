;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

;; A Result is a Number

(define-struct add [left right])
(define-struct mul [left right])

;; A BSL-expr is one of:
;; --- Number
;; --- (make-add BSL-expr BSL-expr)
;; --- (make-mul BSL-expr BSL-expr)

(define (eval-expression bsl-expr)
  (match bsl-expr
    [(? number?) bsl-expr]
    [(add left right) (+ (eval-expression left) (eval-expression right))]
    [(mul left right) (* (eval-expression left) (eval-expression right))]
    ))

(check-expect (eval-expression (make-add 10 -10)) 0)
(check-expect (eval-expression (make-add -1 2)) 1)
(check-expect (eval-expression (make-add (make-mul -2 -3) 33)) 39)
(check-within (eval-expression (make-mul (make-add 1 (make-mul 2 3)) 3.14)) 21.98 0.01)
