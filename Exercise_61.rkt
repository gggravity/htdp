(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define RED "red")
(define YELLOW "yellow")
(define GREEN "green")

;; S-TrafficLight -> S-TrafficLight
;; yields the next state, given current state cs
(define (tl-next-symbolic cs)
  (cond
   [(equal? cs RED) YELLOW]
   [(equal? cs YELLOW) GREEN]
   [(equal? cs GREEN) RED]))

;; State -> Image
;; return Image based on the current state
(define (place-light-symbolic cs)
  (cond
   [(equal? (tl-next-symbolic cs) RED) (circle 15 "solid" GREEN)]
   [(equal? (tl-next-symbolic cs) GREEN) (circle 15 "solid" YELLOW)]
   [(equal? (tl-next-symbolic cs) YELLOW) (circle 15 "solid" RED)]))

;; State -> Number
;; the position of the different color of lights
(define (x-light cs)
  (cond
   [(equal? cs RED) 0]
   [(equal? cs YELLOW) 30]
   [(equal? cs GREEN) 60]))

;; TrafficLight -> Image
;; renders the current state cs as an image
(define (tl-render current-state)
  (place-image/align (place-light-symbolic current-state) (x-light current-state) 0 "left" "top"
		     (empty-scene 90 30)))

;; TrafficLight -> TrafficLight
;; simulates a clock-based traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
	    [to-draw tl-render]
	    [on-tick tl-next-symbolic 1]))

(traffic-light-simulation RED)
