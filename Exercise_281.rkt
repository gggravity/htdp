;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define less10 (λ (x) (< 10 x)))

(check-expect (filter less10 (build-list 10 sqr))
              '(16 25 36 49 64 81))

(define miltiply-string (λ (x y) (string-append (number->string (* x y)))))

(check-expect (miltiply-string 3 3) "9")

(define even-odd-1-2 (λ (x) (if (even? x) 0 1)))

(check-expect (map even-odd-1-2 (build-list 10 add1))
              '(1 0 1 0 1 0 1 0 1 0))

(define-struct inventory [name price])

(define compare-price (λ (cmp a b) (cmp (inventory-price a) (inventory-price b))))

(check-expect (compare-price < (make-inventory "item-1" 32) (make-inventory "item-2" 11)) #false)
(check-expect (compare-price > (make-inventory "item-1" 32) (make-inventory "item-2" 11)) #true)
(check-expect (compare-price = (make-inventory "item-1" 11) (make-inventory "item-2" 11)) #true)

(define add-red-dot (λ (p img) (place-image (circle 5 "solid" "red") (posn-x p) (posn-y p) img)))

(check-expect (add-red-dot (make-posn 10 10) (empty-scene 20 20))
              (place-image (circle 5 "solid" "red") 10 10 (empty-scene 20 20)))



