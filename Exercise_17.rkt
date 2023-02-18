;; Define the function image-classify, which consumes an
;; image and conditionally produces "tall" if the image is taller than wide, "wide"
;; if it is wider than tall, or "square" if its width and height are the same. See
;; exercise 8 for ideas.

(define cat (rectangle 100 100 "solid" "chocolate"))

(define (image-classify x)
  (if (image? x)
      (if (=  (image-width x) (image-height x)) "square"
	  (if (> (image-width x) (image-height x)) "wide"
	      "tall"))
      "ERROR: not a image"))

(image-classify "hello world")
(image-classify cat)
