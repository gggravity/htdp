(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; TrafficLight -> TrafficLight
;; yields the next state, given current state cs
(define (tl-next cs)
  (cond
   [(string=? "red" cs) "green"]
   [(string=? "green" cs) "yellow"]
   [(string=? "yellow" cs) "red"]))

;; State -> image
;; return a image based on current state
(define (place-light cs)
  (circle 15 "solid" (traffic-light-next cs)))

;; State -> Number
;; the position of the different color of lights
(define (x-light cs)
  (cond
   [(string=? "red" cs) 30]
   [(string=? "yellow" cs) 0]
   [(string=? "green" cs) 60]))

;; TrafficLight -> Image
;; renders the current state cs as an image
(define (tl-render current-state)
  (place-image/align (place-light current-state) (x-light current-state) 0 "left" "top"
		     (empty-scene 90 30)))

;; TrafficLight -> TrafficLight
;; simulates a clock-based traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
	    [to-draw tl-render]
	    [on-tick tl-next 1]))

(traffic-light-simulation "yellow")
