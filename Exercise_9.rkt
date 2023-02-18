;; create an expression that converts the value of in to a positive number.
;;
;; For a String, it determines how long the String is;
;; for an Image, it uses the area;
;; for a Number, it decrements the number by 1, unless it is already 0 or negative
;; for #true it uses 10 and for #false 20.


(require 2htdp/image)
(require 2htdp/universe)

;; (define in (beside
;; 	    (rotate 30 (square 50 "solid" "red"))
;; 	    (flip-horizontal
;; 	     (rotate 30 (square 50 "solid" "blue")))))

;; (define in #false)

(define in "some string")



(define (convert value)
  (if (string? value) (string-length value)
      (if (image? value) (* (image-width value) (image-height value))
	  (if (number? value) (if (> value 0) (- value 1) value )
	      (if (and boolean? value #true) "10"
	      "20"
	      )))))


(convert in)
