;; Exercise 45

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)


;; dimensions of the scene
(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 200)

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD "transparent"))

;; location of the cat bitmap
(define cat1 (bitmap "images/cat1.png"))


;; The vertical offset of the car.
(define CAT-Y
  (/ HEIGHT-OF-WORLD 2))

;; An AnimationState is a Number.
;; interpretation the number of clock ticks
;; since the animation started

(define(tock ws)
  (if (< ws (+ WIDTH-OF-WORLD (/ (image-width cat1) 2)))
      (+ ws 3)
      0))

;; WorldState -> Image
;; places the car into the BACKGROUND scene,
;; according to the given world state

(define (render ws)
  (if (= (modulo ws 2) 0)
      (place-image (rotate (random 4) cat1) ws  CAT-Y BACKGROUND)
      (place-image (rotate (- (random 4)) cat1) ws CAT-Y BACKGROUND)))

;; WorldState -> WorldState
;; launches the program from some initial state
(define (main ws)
  (big-bang ws
	    [on-tick tock]
	    [to-draw render]))

(main 0)