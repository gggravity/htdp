;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

; An Atom is one of:
; – Number
; – String
; – Symbol

(define (atom? value)
  (or (number? value)
      (string? value)
      (symbol? value)))

(define (depth list-of-sexp)
  (local ((define (count-sl sl)
            (cond
              [(empty? sl) 1]
              [else
               (+ (depth (first sl)) (count-sl (rest sl)))])))
    (cond
      [(atom? list-of-sexp) 0]
      [else (count-sl list-of-sexp)])))

(check-expect (depth '(a b c c e (a c (a b) c b))) 3)
(check-expect (depth '(a a a a a)) 1)
(check-expect (depth '(((((((((())))))))))) 10)
(check-expect (depth '(((((((((((((((())))))))))(((())))))))))) 20)

