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

(define (subst ex x v)
  (match ex
    [(? number?) ex]
    [(? symbol?) (if (symbol=? x ex) v ex)]
    [(add left right) (make-add (subst left x v) (subst right x v))]
    [(mul left right) (make-mul (subst left x v) (subst right x v))]
    [(fn name parm) (make-fn name (subst parm x v))]
    ))

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

(define (eval-function* ex da)
  (match ex
    [(? number?) ex]
    [(add left right) (+ (eval-function* left da)
                         (eval-function* right da))]
    [(mul left right) (* (eval-function* left da)
                         (eval-function* right da))]
    [(fn name parm) (local ((define b (fn-def-body (lookup-def da name)))
                            (define p (fn-def-parm (lookup-def da name)))
                            (define value (eval-function* parm da))
                            (define plugd (subst b p value)))
                      (eval-function* plugd da))]
    ))

(check-expect (eval-function* 1 da-fgh) 1)
(check-expect (eval-function* (make-add 1 1) da-fgh) 2)
(check-expect (eval-function* (make-mul 1 2) da-fgh) 2)
(check-expect (eval-function* (make-fn 'f 1) da-fgh) 4)
(check-expect (eval-function* (make-fn 'g 1) da-fgh) 5)
(check-expect (eval-function* (make-fn 'h 1) da-fgh) 9)

(define close-to-pi 3.14)

(define (area-of-circle r)
  (* close-to-pi (* r r)))

(define (volume-of-10-cylinder r)
  (* 10 (area-of-circle r)))

(check-expect (area-of-circle 1) 3.14)
(check-expect (volume-of-10-cylinder 1) 31.4)
(check-expect (* 3 close-to-pi) 9.42)

(define-struct const-def (name val))

(define conl1 (list (make-const-def 'area-of-circle 3.14)
                    (make-const-def 'volume-of-10-cylinder 31.4)
                    ))

(define (lookup-con-def da x)
  (cond
    [(empty? da) (error "not found")]
    [(symbol=? x (const-def-name (first da))) (first da)]
    [else (lookup-con-def (rest da) x)]
    ))

(check-expect (lookup-con-def conl1 'area-of-circle) (make-const-def 'area-of-circle 3.14))
(check-error (lookup-con-def conl1 'a) "not found")

(define (lookup-fun-def da f)
  (cond
    [(empty? da) (error "not found")]
    [(symbol=? f (fn-def-name (first da))) (first da)]
    [else (lookup-fun-def (rest da) f)]
    ))

(check-expect (lookup-fun-def da-fgh 'f) f-def)
(check-expect (lookup-fun-def da-fgh 'g) g-def)
(check-expect (lookup-fun-def da-fgh 'h) h-def)
(check-error (lookup-fun-def da-fgh 'x) "not found")

