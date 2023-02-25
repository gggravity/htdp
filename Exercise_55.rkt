(define HEIGHT 300) ; distances in pixels
(define WIDTH 100)
(define YDELTA 3)
(define BACKG (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))

(define (p-image x)
  (place-image ROCKET 10 (- x CENTER) BACKG))

(define (p-image-text x)
  (place-image (text (number->string x) 20 "red") 10 (* 3/4 WIDTH) (p-image x)))

(define (show x)
  (cond
   [(string? x) (p-image x)]
   [(<= -3 x -1) (p-image-text x)]
   [(>= x 0) (p-image x)]))

(show 10)
