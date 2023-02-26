(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; N-TrafficLight -> N-TrafficLight
;; yields the next state, given current state cs
(define (tl-next-numeric cs)
  (modulo (+ cs 1) 3))

;; State -> image
;; return a image based on current state
(define (place-light cs)
  (circle 15 "solid" (tl-next-numeric cs)))

(define (place-light-numeric cs)
  (cond
   [(= (tl-next-numeric cs) 0) (circle 15 "solid" "green")]
   [(= (tl-next-numeric cs) 1) (circle 15 "solid" "yellow")]
   [(= (tl-next-numeric cs) 2) (circle 15 "solid" "red")]))

;; State -> Number
;; the position of the different color of lights
(define (x-light cs)
  (cond
   [(= cs 0) 30]
   [(= cs 1) 0]
   [(= cs 2) 60]))

;; TrafficLight -> Image
;; renders the current state cs as an image
(define (tl-render current-state)
  (place-image/align (place-light-numeric current-state) (x-light current-state) 0 "left" "top"
		     (empty-scene 90 30)))

;; TrafficLight -> TrafficLight
;; simulates a clock-based traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
	    [to-draw tl-render]
	    [on-tick tl-next-numeric 1]))

(traffic-light-simulation 1)
