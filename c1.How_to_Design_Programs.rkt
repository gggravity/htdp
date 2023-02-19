(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; Number -> Number
;; computes the area of a square with side len
;; given: 2, expect: 4
;; given: 7, expect: 49
(define (area-of-square len)
  (sqr len))


;; Number String Image->Image
;; adds s to img, y pixels from top, 10 pixels to the left
;; given:
;;   5 for y,
;;   "hello" for s, and
;;   (empty-scene 100 100) for img
;; expect:
;;   (place-image (text "hello" 10 "red") 10 5 ...)
;;   where ... is (empty-scene 100 100)
(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))

;; (area-of-square 2)
;; (area-of-square 7)

;; (add-image 5 "hello" (empty-scene 100 100))


;; Number -> Number
;; converts Fahrenheit temperatures to Celsius

(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)

(define (f2c f)
  (* 5/9 (- f 32)))

;; (f2c 212)
