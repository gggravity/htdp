;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (f-plain x)
  (* 10 x))

(define f-lambda
  (λ (x) (* 10 x)))

(define (compare x)
  (= (f-plain x) (f-lambda x)))

(check-expect (compare (random 100000)) #true)
