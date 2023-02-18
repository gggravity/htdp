(define cat (rectangle 100 100 "solid" "chocolate"))


(define (tall_or_wide image)
  (if (=  (image-width image) (image-height image)) "square"
      (if (> (image-width image) (image-height image)) "wide"
	  "tall")))


(tall_or_wide cat)
