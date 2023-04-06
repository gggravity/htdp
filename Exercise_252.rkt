;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; Posn Image -> Image 
(define (place-dot p img)
  (place-image dot (posn-x p) (posn-y p) img))

; graphical constants:    
(define emt (empty-scene 100 100))
(define dot (circle 3 "solid" "red"))

; [List-of Number] -> Number
(define (product l)
  (cond
    [(empty? l) 1]
    [else (* (first l) (product (rest l)))]))

; [List-of Posn] -> Image
(define (image* l)
  (cond
    [(empty? l) emt]
    [else (place-dot (first l) (image* (rest l)))]))

(define (fold2 r s l)                   ; same as the old one?
  (if (empty? l) s
      (r (first l) (fold2 r s (rest l)))))

(define list2 (list (make-posn 1 2) (make-posn 3 4) (make-posn 5 6) (make-posn 7 8)))

(define (image*2 l)
  (fold2 place-dot emt l))

(check-expect (image*2 list2) (image* list2))
