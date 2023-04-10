;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 100)
(define HEIGHT 300)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "images/rocket.png"))   

; An ImageStream is a function: 
;   [N -> Image]
; interpretation a stream s denotes a series of images
(define (render state)
  (place-image ROCKET (/ WIDTH 2) state BACKGROUND))

(define (my-animate stream)
  (big-bang HEIGHT
            [to-draw stream]
            [on-tick sub1 0.005]
            [stop-when (λ (state) (zero? state))]))

(my-animate render)
