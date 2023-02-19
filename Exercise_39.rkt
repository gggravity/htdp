;; Develop your favorite image of an automobile so that WHEEL-RADIUS remains
;; the single point of control.

(require 2htdp/image)
(require 2htdp/universe)

(define BACKGROUND (empty-scene 1000 1000 "white"))
(define WIDTH-OF-WORLD 200)
(define WHEEL-RADIUS 50)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle (*  WHEEL-RADIUS 7) (*  WHEEL-RADIUS 7) "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR
  (overlay/xy
   (rectangle (/ (image-width BOTH-WHEELS) 4) (/ (image-height BOTH-WHEELS) 1.8) "solid" "white")
   0 (/ WHEEL-RADIUS 0.4)
   (overlay/xy (rectangle (image-width BOTH-WHEELS) (/ (image-height BOTH-WHEELS) 2) "solid" "seagreen")
	       0 0 BOTH-WHEELS))
  )


(place-image CAR 500 500 BACKGROUND)
