;; Exercise 47

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; dimensions of the scene
(define WIDTH 100)
(define HEIGHT 20)

;; define happines
(define (happines ws)
 (rectangle (- WIDTH ws) HEIGHT "solid" "red"))


;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

;; An AnimationState is a Number.
;; interpretation the number of clock ticks
;; since the animation started

(define(tock ws)
  (cond [(< ws WIDTH) (+ ws 0.1)]
	[else WIDTH]))

;; WorldState -> Image
;; places the car into the BACKGROUND scene,
;; according to the given world state

(define (render ws)
  (place-image/align (happines ws) 0 0 "left" "top" BACKGROUND))


;; CS KeyEvent -> CS
;; mouse event for feeding and petting the cat
;; use up arrow to pet the cat and down arrow to feeds the cat

(define (pet ws)
  (- ws (/ (- WIDTH ws) 5)))

(define (feed ws)
  (- ws (/ (- WIDTH ws) 3)))

(define (cat-attention ws ke)
  (cond [(key=? ke "up") (pet ws)]
        [(key=? ke "down") (feed ws)]
        [else ws]))

;; WorldState -> WorldState
;; launches the program from some initial state
(define (main ws)
  (big-bang ws
	    [on-tick tock]
	    [to-draw render]
	    [on-key cat-attention]))

(main 0)
