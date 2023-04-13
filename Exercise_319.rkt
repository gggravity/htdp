;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

; An Atom is one of:
; – Number
; – String
; – Symbol

(define (substitute sexp from to)
  (local ((define (atom? atom)
            (or (number? atom) (string? atom) (symbol? atom)))
          (define (loop sl)
            (if (empty? sl) '()
                (cons (substitute (first sl) from to) (loop (rest sl)))))
          (define (change atom)
            (if (equal? atom from) to atom)))
    (if (atom? sexp) (change sexp)
        (loop sexp))))

(check-expect (substitute '(a b c c e (a c c b)) 'c 'x)
              '(a b x x e (a x x b)))
(check-expect (substitute '(a a a a a) 'a 'c)
              '(c c c c c))
(check-expect (substitute '(a a a a a) 'c 'a)
              '(a a a a a))
(check-expect (substitute 'a 'c 'a) 'a)
(check-expect (substitute 'a 'a 'c) 'c)
