;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define (atom? atom)
  (or (number? atom) (string? atom) (symbol? atom)))

(define WRONG "ERROR: something went WRONG")

(define-struct add [left right])
(define-struct mul [left right])


(define-struct fn [name expr])

;; A BSL-fn-expr is one of: 
;; – Number
;; – Symbol 
;; – (make-add BSL-fn-expr BSL-fn-expr)
;; – (make-mul BSL-fn-expr BSL-fn-expr)
;; – (make-fn Symbol BSL-fn-expr)
;;
;; Examples:
;; 
;; (k (+ 1 1)) -> (make-fn 'k (make-add 1 1))
;;
;; (* 5 (k (+ 1 1))) -> (make-mul 5 (make-fn 'k (make-add 1 1)))
;;
;; (* (i 5) (k (+ 1 1))) -> (make-mul (make-fn 'i 5) (make-fn 'k (make-add 1 1))) 

