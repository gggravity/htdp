;; A WorldState is a Number.
;; interpretation number of pixels between the top and the UFO

(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (ellipse 40 7 "outline" "green")))

;; WorldState -> WorldState
(define (main y0)
  (big-bang y0
            [on-tick nxt]
            [to-draw render]))

;; WorldState -> WorldState
;; computes next location of UFO 

(check-expect (nxt 11) 14)

(define (nxt y)
  (+ y 3))

;; WorldState -> Image
;; places UFO at given height into the center of MTSCN

(check-expect (render 11) (place-image UFO 14 11 MTSCN))

(define (render y)
  (place-image UFO (nxt y) y MTSCN))

(main 0)
