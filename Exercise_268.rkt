;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define (convert-usd-eur loc)
  (local ((define (usd-eur amount)
            (* amount 1.06)))
    (map usd-eur loc)))

(define l (build-list 10 add1))


(check-expect (convert-usd-eur l) '(1.06 2.12 3.18 4.24 5.3 6.36 7.42 8.48 9.54 10.6))
