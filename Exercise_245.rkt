;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define (function=at-1.2-3-and-5.775? f1 f2)
  (and (equal? (f1 1.2) (f2 1.2))
       (equal? (f1 3) (f2 3))
       (equal? (f1 5.775) (f2 5.775))
       ))

(define (test_func1 x)
  (- (+ x 1) 1))

(define (test_func2 x)
  (sub1 (add1 x)))

(check-expect (function=at-1.2-3-and-5.775? test_func1 test_func2) #true)
