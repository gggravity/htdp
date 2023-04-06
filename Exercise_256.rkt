;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; [X] [X -> Number] [NEList-of X] -> X 
;; finds the (first) item in lx that maximizes f
;; if (argmax f (list x-1 ... x-n)) == x-i, 
;; then (>= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...
;; (define (argmax f lx) ...)

(define (append-item i)
  (string-append "item-" i))

(define l1 (map append-item (map number->string (build-list 10 add1))))

(check-expect (argmax string-length l1) "item-10")

(check-expect (argmin string-length l1) "item-1")
