;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct vcat [x-pos happy])
;; vcat is a Number Number, last Number is between 0 and 100
;; usage: (make-vcat Number Number) 
;; interpretation: (make-vcat x h)
;; x is the x-coordinate of the cat and h is the happines of the cat (0-100)

;; vcat -> vcat
(define (cat-function c)
  (make-vcat
   (vcat-x-pos c)
   (vcat-happy c)))

(define cat1 (make-vcat 40 50))

(cat-function cat1)
