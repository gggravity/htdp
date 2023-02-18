(define cat (rectangle 10 100 "solid" "chocolate"))

(define (image-area x)
  (if (image? x) (* (image-width x) (image-height x)) "Not a image!"))


(image-area cat)
;; (image-area 1234)

