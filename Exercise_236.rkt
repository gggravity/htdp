;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; Lon -> Lon
;; adds 1 to each item on l
(define (add1* l)
  (cond
   [(empty? l) '()]
   [else
    (cons
     (add1 (first l))
     (add1* (rest l)))]))

(check-expect (add1* '(1 2 3)) '(2 3 4))

;; Lon -> Lon
;; adds 5 to each item on l
(define (plus5 l)
  (cond
   [(empty? l) '()]
   [else
    (cons
     (+ (first l) 5)
     (plus5 (rest l)))]))

(check-expect (plus5 '(1 2 3)) '(6 7 8))

(define (add-n n l)
  (if (empty? l) '()
      (cons (+ (first l) n) (add-n n (rest l)))
      ))

(define (add-5 l)
  (add-n 5 l))

(check-expect (plus5 '(1 2 3)) (add-5 '(1 2 3)))

(define (add-1 l)
  (add-n 1 l))

(check-expect (add1* '(1 2 3)) (add-1 '(1 2 3)))

(define (sub-2 l)
  (add-n -2 l))

(check-expect (sub-2 '(1 2 3)) '(-1 0 1))
