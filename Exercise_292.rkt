;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define (sorted cmp)
  (λ (l)
    #true))

; [X X -> Boolean] [NEList-of X] -> Boolean 
; determines whether l is sorted according to cmp

(define (sorted? cmp l)
  (if (empty? (rest l)) #true
      (and
       (cmp (first l) (first (rest l)))
       (sorted? cmp (rest l)))))

(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(2 1 3)) #false)

