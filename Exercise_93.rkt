;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define-struct chameleon [x-pos happy color])

;; dimensions of the scene
(define WIDTH 1000)
(define HEIGHT 400)

;; the speed of the cat
(define cham-speed 5)

;; location of the cat bitmap
(define cham-image (bitmap "images/chameleon.png"))

(define (cham-background color)
  (rectangle (image-width cham-image)
             (image-height cham-image)
             "solid"
             color))

;; define happines
(define (happines cham)
  (rectangle (* 10 ( chameleon-happy cham)) (/ HEIGHT 2) "solid" "yellow"))

;; the background of the scene 
;; (define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))
(define BACKGROUND
  (beside (empty-scene (/ WIDTH 3) HEIGHT "green")
          (empty-scene (/ WIDTH 3) HEIGHT "white")
          (empty-scene (/ WIDTH 3) HEIGHT "red")))

(define(tock cham)
  (cond
    [(and (> (chameleon-happy cham) 0) (< (chameleon-x-pos cham) WIDTH))
     (make-chameleon (+ (chameleon-x-pos cham) cham-speed)
                     (- (chameleon-happy cham) 0.5)
                     (chameleon-color cham))]
    [(and (> (chameleon-happy cham) 0) (>= (chameleon-x-pos cham) WIDTH))
     (make-chameleon 0
                     (- (chameleon-happy cham) 0.5)
                     (chameleon-color cham))]
    [else cham]))

(define (render cham)
  (place-image
   (overlay cham-image (cham-background(chameleon-color cham))) (chameleon-x-pos cham) (* HEIGHT 0.75)
   (place-image/align (happines cham) 0 0 "left" "top" BACKGROUND)))

(define (feed cham)
  (cond
    [(>=  (chameleon-happy cham) 100) cham]
    [else (make-chameleon (chameleon-x-pos cham)
                          (+ (chameleon-happy cham) 25)
                          (chameleon-color cham))]))

(define (red cham)
  (make-chameleon (chameleon-x-pos cham)
                  (chameleon-happy cham)
                  "red"))

(define (green cham)
  (make-chameleon (chameleon-x-pos cham)
                  (chameleon-happy cham)
                  "green"))

(define (blue cham)
  (make-chameleon (chameleon-x-pos cham)
                  (chameleon-happy cham)
                  "blue"))

(define (attention cham ke)
  (cond [(key=? ke "down") (feed cham)]
        [(key=? ke "r") (red cham)]
        [(key=? ke "g") (green cham)]
        [(key=? ke "b") (blue cham)]
        [else cham]))

(define (main cham)
  (big-bang cham
	    [on-tick tock]
	    [to-draw render]
	    [on-key attention]))

(main (make-chameleon 0 100 "green"))
