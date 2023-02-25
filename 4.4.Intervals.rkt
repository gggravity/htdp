(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

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
            [to-draw render/status]))

;; WorldState -> WorldState
;; computes next location of UFO 

(check-expect (nxt 11) 12)

(define (nxt y)
  (+ y 1))

;; WorldState -> Image
;; places UFO at given height into the center of MTSCN

(check-expect (render 11) (place-image UFO 12 11 MTSCN))

(define (render y)
  (place-image UFO (nxt y) y MTSCN))

;; WorldState -> Image
;; adds a status line to the scene created by render  

(check-expect (render/status 42)
              (place-image (text "closing in" 11 "orange")
                           265 90
                           (render 42)))

(define (render/status y)
  (place-image
   (cond
    [(<= 0 y CLOSE)
     (text "descending" 11 "green")]
    [(and (< CLOSE y) (<= y HEIGHT))
     (text "closing in" 11 "orange")]
    [(> y HEIGHT)
     (text "landed" 11 "red")])
   265 90
   (render y)))

(main 0)
