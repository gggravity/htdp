;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define (atom? atom)
  (or (number? atom) (string? atom) (symbol? atom)))

(define WRONG "ERROR: something went WRONG")

(define-struct add [left right])
(define-struct mul [left right])

;; A BSL-expr is one of:
;; --- Number
;; --- (make-add BSL-expr BSL-expr)
;; --- (make-mul BSL-expr BSL-expr)

;; S-expr -> BSL-expr
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))

;; SL -> BSL-expr 
(define (parse-sl s)
  (local ((define L (length s)))
    (cond
      [(< L 3) (error WRONG)]
      [(and (= L 3) (symbol? (first s)))
       (cond
         [(symbol=? (first s) '+)
          (make-add (parse (second s)) (parse (third s)))]
         [(symbol=? (first s) '*)
          (make-mul (parse (second s)) (parse (third s)))]
         [else (error WRONG)])]
      [else (error WRONG)])))

;; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))

(check-expect (parse '(+ 1 2)) (make-add 1 2))
(check-expect (parse '(* 1 2)) (make-mul 1 2))

(check-error (parse '(/ 1 2)) WRONG)
(check-error (parse "") WRONG)
(check-error (parse 'x) WRONG)
(check-error (parse '(+ 1)) WRONG)
(check-error (parse '(+ 1 2 3)) WRONG)

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

(define (interpreter-expr sexp)
  (eval-expression (parse sexp)))

(check-expect (interpreter-expr '(+ 1 2)) 3)
(check-expect (interpreter-expr '(* 1 2)) 2)

(check-error (interpreter-expr '(/ 1 2)) WRONG)
(check-error (interpreter-expr "") WRONG)
(check-error (interpreter-expr 'x) WRONG)
(check-error (interpreter-expr '(+ 1)) WRONG)
(check-error (interpreter-expr '(+ 1 2 3)) WRONG)


; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

(define (subst ex x v)
  (match ex
    [(? number?) ex]
    [(? symbol?) (if (symbol=? x ex) v ex)]
    [(add left right) (make-add (subst left x v) (subst right x v))]
    [(mul left right) (make-mul (subst left x v) (subst right x v))]
    ))

(check-expect (subst (make-add 10 'a) 'a 12) (make-add 10 12))
(check-expect (subst (make-add 'a 'a) 'a 12) (make-add 12 12))

(define (numeric? ex)
  (match ex
    [(? number?) #true]
    [(? symbol?) #false]
    [(add l r) (andmap numeric? (list l r))]
    [(mul l r) (andmap numeric? (list l r))]
    ))

(check-expect (numeric? (make-add 1 2)) #true)
(check-expect (numeric? (make-add 'a 2)) #false)

(define (eval-variable ex)
  (if (numeric? ex) (eval-expression ex) (error WRONG))
  )

(check-expect (eval-variable (make-add 1 2)) 3)
(check-error (eval-variable (make-add 'a 2)) WRONG)

; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

(define (eval-variable* ex da)
  (local ((define fn (λ (p e) (subst e (first p) (second p)))))
    (eval-expression (if (numeric? ex)
                         (error WRONG)
                         (foldl fn ex da)))))

(define al1 '(a 12))
(define al2 '((a 12) (b 21)))

(check-expect (eval-variable* (make-add 10 'a) al2) 22)
(check-expect (eval-variable* (make-mul (make-add 'a 2) 'a) al2) 168)

(define (eval-var-lookup ex da)
  (match ex
    [(? number?) ex]
    [(? symbol?) (if (false? (assq ex da))
                     (error WRONG)
                     (second (assq ex da)))]
    [(add l r) (+ (eval-var-lookup l da) (eval-var-lookup r da))]
    [(mul l r) (* (eval-var-lookup l da) (eval-var-lookup r da))]
    ))

(check-expect (eval-var-lookup (make-add 10 'a) al2) 22)
(check-expect (eval-var-lookup (make-add 'a 10) al2) 22)
(check-expect (eval-var-lookup (make-mul (make-add 'a 2) 'a) al2) 168)
(check-expect (eval-var-lookup (make-mul (make-add 'a 2) 'b) al2) 294)

