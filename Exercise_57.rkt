(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define height 200)
(define width 30)
(define center (/ width 2))  
(define dy 3)
(define background (empty-scene width height))
(define rocket (bitmap "images/rocket.png"))

;; static image of the resting rocket
(define resting (place-image/align rocket (/ width 2) height "center" "bottom" background))

;; image of the rocket with placement based on the worldstate.
(define (flying ws)
  (place-image/align rocket (/ width 2) (- height ws) "center" "bottom" background))

(define (count-down x)
  (place-image (text (number->string x) 20 "red") 10 (* 3/4 width) (flying 0)))

(define (show x)
  (cond
   [(string? x) resting]
   [(<= -3 x -1) (count-down x)]
   [(>= x 0) (flying x)]))

  
(define (launch x ke)
  (cond
   [(string? x) (if (string=? " " ke) -3 x)]
   [(<= -3 x -1) x]
   [(>= x 0) x]))

(define (fly x)
  (cond
   [(string? x) x]
   [(<= -3 x -1) (+ x 1)]
   [(>= x 0) (+ x dy)]))

(define (main s)
  (big-bang s
	    [on-tick fly 0.3]
	    [to-draw show]
	    [on-key launch]
	    ))

(main "resting")
