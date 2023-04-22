;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define (atom? atom)
  (or (number? atom) (string? atom) (symbol? atom)))

(define WRONG "ERROR: something went WRONG")

(define-struct add [left right])
(define-struct mul [left right])

(define (eval-expression bsl-expr)
  (match bsl-expr
    [(? number?) bsl-expr]
    [(add left right) (+ (eval-expression left) (eval-expression right))]
    [(mul left right) (* (eval-expression left) (eval-expression right))]
    ))

(define (subst ex x v)
  (match ex
    [(? number?) ex]
    [(? symbol?) (if (symbol=? x ex) v ex)]
    [(add left right) (make-add (subst left x v) (subst right x v))]
    [(mul left right) (make-mul (subst left x v) (subst right x v))]
    ))

(define-struct fn [name parm])

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


(define (eval-definition1 ex f x b)
  (match ex
    [(? number?) ex]
    [(add left right) (+ (eval-definition1 left f x b)
                         (eval-definition1 right f x b))]
    [(mul left right) (* (eval-definition1 left f x b)
                         (eval-definition1 right f x b))]
    [(fn name parm) (local ((define value (eval-definition1 parm f x b))
                            (define plugd (subst b x value)))
                      (eval-definition1 plugd f x b))]
    ))

(check-expect (eval-definition1 (make-fn 'k (make-add 1 1))
                                'k
                                'a
                                (make-add 'a 'a)
                                ) 4)

(check-expect (eval-definition1 (make-mul 5 (make-fn 'k (make-add 1 1)))
                                'k
                                'a
                                (make-add 'a 'a)                  
                                ) 20)

(check-expect (eval-definition1 (make-mul (make-fn 'i 5) (make-fn 'k (make-add 1 1)))
                                'k
                                'a
                                (make-add 'a 'a)
                                ) 40)
