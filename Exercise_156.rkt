;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 400)
(define WIDTH 100)
(define XSHOT (/ WIDTH 2))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 10 "solid" "red"))

;; ShotWorld -> ShotWorld
;; moves each shot up by one pixel
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))

(check-expect (tock '()) '())
(check-expect (tock (cons 1 '())) (cons 0'()))
(check-expect (tock (cons 11 (cons 1 '()))) (cons 10 (cons 0'())))

;; ShotWorld KeyEvent -> ShotWorld
;; adds a shot to the world if the space bar is hit
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh '() "A") '())

;; ShotWorld -> Image
;; adds each shot y on w at (XSHOT, y) to BACKGROUND
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOT (first w)
                       (to-image (rest w)))]))

(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 1 '())) (place-image SHOT XSHOT 1 BACKGROUND))
(check-expect (to-image (cons 111 (cons 1 '())))
              (place-image SHOT XSHOT 111
              (place-image SHOT XSHOT 1 BACKGROUND)))

;; ShotWorld -> ShotWorld
(define (main w0)
  (big-bang w0
            (on-tick tock)
            (on-key keyh)
            (to-draw to-image)))

(main '())
