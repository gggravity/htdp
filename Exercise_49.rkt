(define (my-exp y)
  (- 200 (cond [(> y 200) 0] [else y])))

(my-exp 100)
(my-exp 210)

;; rocket part


(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "images/rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

(define (create-rocket-scene.v5 h)
  (cond
   [(<= h ROCKET-CENTER-TO-TOP)
    (place-image ROCKET 50 h MTSCN)]
   [(> h ROCKET-CENTER-TO-TOP)
    (place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)]))

(define (within h)
    (cond
     [(<= h ROCKET-CENTER-TO-TOP) h]
     [else ROCKET-CENTER-TO-TOP]))

(define (create-rocket-scene.v6 h)
    (place-image ROCKET 50 (within h) MTSCN))

;; (create-rocket-scene.v5 (/ HEIGHT 2))
(create-rocket-scene.v6 100)
