(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; globals
(define width  200)
(define height 200)
(define rocket (bitmap "images/rocket.png"))
(define background (empty-scene width height))

;; only change the worldstate the tock if it's negative
(define (tock ws)
  (cond
   [(= ws 0) 0]
   [(< ws 0) (- ws 3)]))

;; static image of the resting rocket
(define resting (place-image/align rocket (/ width 2) height "center" "bottom" background))


;; image of the rocket with placement based on the worldstate.
(define (flying ws)
  (place-image/align rocket (/ width 2) (+ height ws) "center" "bottom" background))

;; render as resting if ws is 0 or flying if negative
(define (render ws)
  (cond
   [(= ws 0) resting]
   [(< ws 0) (flying ws)]))

;; change the worldstate to negative to start the animation.
(define (launch x-coordinate x-mouse y-mouse me)
  (cond
   [(string=? "button-down" me) -1]
   [else x-coordinate]))

;; main function
(define (main ws)
  (big-bang ws
	    [on-tick tock]
	    [on-mouse launch]
	    [to-draw render]))

(main 0)
