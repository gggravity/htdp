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
    [(mul left right) (* (eval-expression left) (eval-expression right))]))

(check-expect (eval-expression (make-add 10 -10)) 0)
(check-expect (eval-expression (make-add -1 2)) 1))
(check-expect (eval-expression (make-add (make-mul -2 -3) 33)) 39)
(check-within (eval-expression (make-mul (make-add 1 (make-mul 2 3)) 3.14)) 21.98 0.01)

(define-struct bool-and [left right])
(define-struct bool-or [left right])
(define-struct bool-not [expr])

;; A Boolean-BSL-expr is one of:
;; --- #true
;; --- #false
;; --- (make-bool-and Boolean-BSL-expr Boolean-BSL-expr)
;; --- (make-bool-or Boolean-BSL-expr Boolean-BSL-expr)
;; --- (make-bool-not Boolean-BSL-expr)

(define (eval-bool-expression bool-bsl-expr)
  (match bool-bsl-expr
    [(? boolean?) bool-bsl-expr]
    [(bool-and left right) (and (eval-bool-expression left) (eval-bool-expression right))]
    [(bool-or left right) (or (eval-bool-expression left) (eval-bool-expression right))]
    [(bool-not expr) (not (eval-bool-expression expr))]))

(check-expect (eval-bool-expression #true) #true)
(check-expect (eval-bool-expression (make-bool-and #true #true)) #true)
(check-expect (eval-bool-expression (make-bool-and #true #false)) #false)
(check-expect (eval-bool-expression (make-bool-or #true #true)) #true)
(check-expect (eval-bool-expression (make-bool-or #true #false)) #true)
(check-expect (eval-bool-expression (make-bool-not #true)) #false)
(check-expect (eval-bool-expression (make-bool-not #false)) #true)
