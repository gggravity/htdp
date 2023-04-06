;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define-struct ir [price amount])

(define il (list (make-ir 1.11 111)
                 (make-ir 2.22 222)
                 (make-ir 3.33 333)
                 (make-ir 0.123 123)
                 (make-ir 0.312 321)))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (ir-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))

(extract1 il)

; there are no benefit of making (extract1 (rest an-inv)) local.
; its run only once, no mater what the value of (<= (ir-price (first an-inv)) 1.0) is. 
