;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define-struct vcat [x-pos happy])
;; vcat is a Number Number, last Number is between 0 and 100
;; usage: (make-vcat Number Number) 
;; interpretation: (make-vcat x h)
;; x is the x-coordinate of the cat and h is the happines of the cat (0-100)

;; dimensions of the scene
(define WIDTH 1000)
(define HEIGHT 400)

;; location of the cat bitmap
(define cat1 (bitmap "images/cat1.png"))

;; define happines
(define (happines cat)
  (rectangle (* 10 (vcat-happy cat)) (/ HEIGHT 2) "solid" "red"))

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

(define(tock cat)
  (cond [(> (vcat-happy cat) 0)
         (make-vcat (+ (vcat-x-pos cat) 1) (- (vcat-happy cat) 0.5))]
	[else cat]))

(define (render cat)
  (place-image cat1 (vcat-x-pos cat) (* HEIGHT 0.75) (place-image/align (happines cat) 0 0 "left" "top" BACKGROUND)))

(define (pet cat)
  (cond
    [(>=  (vcat-happy cat) 100) cat]
    [else 
  (make-vcat (vcat-x-pos cat)
             (+ (vcat-happy cat) 10))]))

(define (feed cat)
    (cond
    [(>=  (vcat-happy cat) 100) cat]
    [else 
  (make-vcat (vcat-x-pos cat)
             (+ (vcat-happy cat) 25))]))

(define (cat-attention cat ke)
  (cond [(key=? ke "up") (pet cat)]
        [(key=? ke "down") (feed cat)]
        [else cat]))

(define (main cat)
  (big-bang cat
	    [on-tick tock]
	    [to-draw render]
	    [on-key cat-attention]))

(main (make-vcat 50 100))

