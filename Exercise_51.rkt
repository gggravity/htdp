(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; globals
(define width  60)
(define height 180)
(define background (empty-scene width height "black"))

;; TrafficLight -> TrafficLight
;; yields the next state given current state s

(check-expect (traffic-light-next "red") "yellow")
(check-expect (traffic-light-next "yellow") "green")
(check-expect (traffic-light-next "green") "red")

(define (traffic-light-next s)
  (cond
   [(string=? "red" s) "yellow"]
   [(string=? "yellow" s) "green"]
   [(string=? "green" s) "red"]))

(define (place-light s)
  (circle 30 "solid" (traffic-light-next s)))

;; the tock
(define(tock ws)
  (traffic-light-next ws))

(define (y-light s)
  (cond
   [(string=? "red" s) 60]
   [(string=? "yellow" s) 120]
   [(string=? "green" s) 0]))


;; the render function
(define (render ws)
  (place-image/align (place-light ws) 0 (y-light ws) "left" "top" background))

;; main function
(define (main ws)
  (big-bang ws
	    [on-tick tock 3]
	    [to-draw render]))

(main "green")
