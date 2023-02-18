(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 200)
(define HEIGHT 400)
(define CIRCLE (circle 5 "solid" "green"))

(define MTSCN (place-image
               (rectangle 40 4 "solid" "green") (/ WIDTH 2) HEIGHT
               (empty-scene WIDTH HEIGHT "blue")))

(define UFO (overlay
             (circle 10 "solid" "green")
             (rectangle 40 4 "solid" "green")))


(define IMAGE UFO)

(define ROCKET-CENTER-TO-TOP (+ 1 (/ (image-height IMAGE) 2)))

(define V 3)

(define (distance t)
  (* V t))


(define (picture-of-circle t)
  (cond
    [(<= (distance t) (- HEIGHT ROCKET-CENTER-TO-TOP))
     (place-image IMAGE (/ WIDTH 2) (distance t) MTSCN)]
    [(> (distance t) (- HEIGHT ROCKET-CENTER-TO-TOP ))
     (place-image IMAGE (/ WIDTH 2) (- HEIGHT ROCKET-CENTER-TO-TOP) MTSCN)]
    ))

(animate picture-of-circle)

