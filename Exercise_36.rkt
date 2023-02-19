;; Image->Image
;; return the number of pixels in an image
;; given:
;;    (empty-scene 100 100)
;; expected:
;;    10000
(define (image-area img)
  (* (image-width img) (image-height img)))

(image-area (empty-scene 100 100))
