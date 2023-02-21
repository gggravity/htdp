;; Exercise 42

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)


;; dimensions of the scene
(define WIDTH-OF-WORLD 800)
(define HEIGHT-OF-WORLD 100)

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD "transparent"))

;; dimensions of the car -> larger wheels larger car.
(define WHEEL-RADIUS 10)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

;; definitions of how the car should be drawn.
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle (*  WHEEL-RADIUS 7) (*  WHEEL-RADIUS 7) "solid" "transparent"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR
  (overlay/xy
   (rectangle (/ (image-width BOTH-WHEELS) 4)
	      (/ (image-height BOTH-WHEELS) 1.8)
	      "solid" "white") 0 (/ WHEEL-RADIUS 0.4)
	      (overlay/xy
	       (rectangle (image-width BOTH-WHEELS)
			  (/ (image-height BOTH-WHEELS) 2)
			  "solid" "seagreen") 0 0 BOTH-WHEELS)))

;; definition for the tree
(define TREE
  (underlay/xy (circle 10 "solid" "green")
	       9 15
	       (rectangle 2 20 "solid" "brown")))

;; x and y coordinates for the placement of the tree in the scene
(define TREE-X (- (image-width CAR) WIDTH-OF-WORLD))
(define TREE-Y (- (/ (image-height CAR) 2) HEIGHT-OF-WORLD))


;; The vertical offset of the car.
(define Y-CAR 50)

;; WorldState -> WorldStateh
;; moves the car by 3 pixels for every clock tick

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define(tock ws)
  (+ ws 3))

;; WorldState -> Image
;; places the car into the BACKGROUND scene,
;; according to the given world state
(define (render ws)
  (place-image CAR ws Y-CAR (overlay/xy TREE TREE-X TREE-Y BACKGROUND)))


(define (END-STATE ws)  (>= ws (- WIDTH-OF-WORLD (/ (image-width CAR) 2))))

;; WorldState -> Boolean
;; after each event, big-bang evaluates (end? ws)
(define (end? ws)
 (END-STATE ws))

;; WorldState -> WorldState
;; launches the program from some initial state
(define (main ws)
  (big-bang ws
	    [on-tick tock]
	    [to-draw render]
	    [stop-when end?]))

(main 0)
