;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; the world state or the game state.
(define-struct world-state [x-pos y-pos]) ;; not the real state, just some random variables for now.

;; dimensions of the scene
(define WIDTH 800)
(define HEIGHT 600)

;; how the ufo should look like
(define UFO (overlay (circle 10 "solid" "orange") (ellipse 40 7 "outline" "green")))

;; how the tank should look like
(define TANK (rectangle 100 30 "solid" "darkgreen"))

;; how the missile should look like
(define MISSILE (rectangle 5 20 "solid" "black"))
  
;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "lightblue"))

;; what to change on every tick
(define(tock state)
  state)

;; the scene to render
(define (render ws)
  (place-image TANK (/ WIDTH 2) HEIGHT
               (place-image MISSILE  (/ WIDTH 2) (+ (world-state-x-pos ws) (/ HEIGHT 2))
                            (place-image UFO (/ WIDTH 2) 0 BACKGROUND)
                            )))

;; function to move the tank left
(define (move-left ws)
  ws)

;; function to move the tank right
(define (move-right ws)
  ws)

;; function to fire a missile from the tank
(define (fire-missile ws)
  (make-world-state
   (- (world-state-x-pos ws) 1)
   (world-state-y-pos ws)))

;; What function to run on difference key presses
(define (key-pressed ws ke)
  (cond [(key=? ke "left") (move-left ws)]
        [(key=? ke "right") (move-right ws)]
        [(key=? ke " ") (fire-missile ws)]
        [else ws]))

;; the main loop of the program
(define (main world-state)
  (big-bang world-state
	    [on-tick tock]
	    [to-draw render]
	    [on-key key-pressed]))

;; run the main loop
(main (make-world-state 0 0))
