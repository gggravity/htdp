(require 2htdp/image)
(require 2htdp/universe)

(define CAT (beside
	     (rotate 30 (square 50 "solid" "red"))
	     (flip-horizontal
	      (rotate 30 (square 50 "solid" "blue")))))

(define (count_pixels image)
  (+ (image-width image) (image-height image)) 
  )


(count_pixels CAT)

(place-image CAT 100 100
	     (empty-scene 200 200 "Sky Blue"))
