;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

((λ ( x y) (+ x ( * x y)))
 1 2
 )
;; 3

((λ (x y)
   (+ x
      (local ((define z (* y y ))) (+ (* 3 z) (/ 1 x)))
      )) 1 2)

;; 14

((λ (x y)
   (+ x
      ((λ (z) (+ (* 3 z) (/ 1 z))) (* y y))
      )) 1 2)

;; 13.25
