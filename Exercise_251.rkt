;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(define (sum l)
  (cond
    [(empty? l) 0]
    [else
     (+ (first l)
        (sum (rest l)))]))

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product (rest l)))]))

(define (fold1 r s l)
  (if (empty? l) s
      (r (first l) (fold1 r s (rest l)))))

(define (sum2 l)
  (fold1 + 0 l))

(define (product2 l)
  (fold1 * 1 l))

(define list1 '(1 2 3 4 5 6 7 8 9))
(check-expect (sum list1) (sum2 list1))
(check-expect (product list1) (product2 list1))
