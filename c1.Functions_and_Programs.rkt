(require 2htdp/image)
(require 2htdp/universe)

(define BACKGROUND (empty-scene 400 400))
(define DOT (circle 5 "solid" "red"))

(define (main y)
  (big-bang y
	    [on-tick sub1]
	    [stop-when zero?]
	    [to-draw place-dot-at]
	    [on-key stop]))

(define (place-dot-at y)
  (place-image DOT 200 y BACKGROUND))

(define (stop y ke)
  100)

(main 400)

;; (place-dot-at 200)
;; (stop 200 "q")
