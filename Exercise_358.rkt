;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define-struct add [left right])
(define-struct mul [left right])


(define-struct fn [name parm])
(define-struct fn-def [name parm body])

(define (f x) (+ 3 x))
(define f-def (make-fn-def 'f 'x (make-add 3 'x)))

(define (g y) (f (* 2 y)))
(define g-def (make-fn-def 'g 'y (make-fn 'f (make-mul 2 'y))))

(define (h v) (+ (f v) (g v)))
(define h-def (make-fn-def 'h 'v (make-add (make-fn 'f 'v) (make-fn 'g 'v))))

(define da-fgh (list f-def g-def h-def))

; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none

(define (lookup-def da f)
  (if (symbol=? f (fn-def-name (first da)))
      (first da)
      (lookup-def (rest da) f)))

(check-expect (lookup-def da-fgh 'f) f-def)
(check-expect (lookup-def da-fgh 'g) g-def)
(check-expect (lookup-def da-fgh 'h) h-def)
