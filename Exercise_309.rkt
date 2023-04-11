;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define lon '(("Adma")
              ("Brian" "Brian" "Brian")
              ("Bob" "Bob")
              ("Bill" "Bill" "Bill" "Bill" "Bill")
              ("Dear" "Dear" "Dear")
              ("Fahrenheit" "Fahrenheit")
              ("James" "James" "James" "James" "James" "James" "James")
              ("Matthew" "Matthew" "Matthew" "Matthew")))

(define (words-on-line los)
  (for/list ((l los))
    (length l)))

(check-expect (words-on-line lon) '(1 3 2 5 3 2 7 4))
