;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; List-of-numbers -> List-of-numbers
;; converts a list of dollers into a list of euros
;
(define (convert-euro fx-list)
  (map (λ (fx)
         (* 0.9291 fx))
       fx-list))

(convert-euro '(10 100 200 333 3000 10000))

;; List-of-numbers -> List-of-numbers
;; convert a list of F degrees into a list C degrees
(define (convertFC degrees)
  (map (λ (degree)
         (exact->inexact (* (- degree 32) 5/9))
         ) degrees))

(convertFC '(100 0 50 150 200))
