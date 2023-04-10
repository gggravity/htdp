;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

((λ (x y)
   (+ x (* x y)))
 2 3)

((λ (x y)
   (+ x
     (local ((define x (* y y)))
       (+ (* 3 x)
          (/ 1 x)))))
 2 3)

((λ (x y)
   (+ x
     ((λ (x)
        (+ (* 3 x)
           (/ 1 x)))
      (* y y))))
 2 3)
