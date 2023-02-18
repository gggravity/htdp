(require 2htdp/image)
(require 2htdp/universe)


(define WIDTH 400)
(define HEIGHT 400)

(define MAST (rectangle 15 160 "solid" "light brown"))
(define SAIL (triangle 130 "solid" "tan"))
(define WATER (rectangle WIDTH (/ HEIGHT 2) "solid" "navy"))

(define SHIP (overlay/xy (rectangle  200 30 "solid" "brown")
			 0 10
			 (ellipse 200 40 "solid" "brown")))

(define SAIL_SHIP
  (overlay/xy
   (overlay/xy SHIP 90 -115 MAST)
   33 -10 SAIL))

;; The program

(place-image SAIL_SHIP
	     (/ WIDTH 2)
	     (/ HEIGHT 2)
	     
	     (place-image WATER
			  (/ WIDTH 2)
			  (+ (/ HEIGHT 2) (/ HEIGHT 3))
			  
			  (empty-scene WIDTH HEIGHT "Sky Blue")))



