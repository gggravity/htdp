;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define l (build-list 10 add1))

(define (map-fold fn l)
    (foldr (λ (f r) (cons (fn f) r)) '() l)
  )

(check-expect (map-fold sqr l) (map sqr l))
(check-expect (map-fold + l) (map + l))
(check-expect (map-fold - l) (map - l))
(check-expect (map-fold / l) (map / l))
(check-expect (map-fold * l) (map * l))


