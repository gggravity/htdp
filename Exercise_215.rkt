;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; dimensions of the scene
(define WIDTH 600)
(define HEIGHT 400)

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

(define WORM (circle 5 "solid" "red"))

(define-struct worm [loc dir])
;; loc is the location
;; loc is a posn
;;
;; dir is the direction
;; dir is one of:
;; UP
;; DOWN
;; LEFT
;; RIGHT
;; START (no movement, used for the start position)

(define (tock ws)
  (cond
    [(string=? (worm-dir ws) "UP") (move-up ws)]
    [(string=? (worm-dir ws) "DOWN") (move-down ws)]
    [(string=? (worm-dir ws) "LEFT") (move-left ws)]
    [(string=? (worm-dir ws) "RIGHT") (move-right ws)]
    [else ws]))

(define (render ws)
  (place-image WORM (posn-x (worm-loc ws)) (posn-y (worm-loc ws)) BACKGROUND))

(define (move-up ws)
  (make-worm
   (make-posn
    (posn-x (worm-loc ws))
    (- (posn-y (worm-loc ws)) 1))
   "UP"))

(check-expect (move-up (make-worm (make-posn 10 10) "START"))
              (make-worm (make-posn 10 9) "UP"))

(define (move-down ws)
  (make-worm
   (make-posn
    (posn-x (worm-loc ws))
    (+ (posn-y (worm-loc ws)) 1))
   "DOWN"))

(check-expect (move-down (make-worm (make-posn 10 10) "START"))
              (make-worm (make-posn 10 11) "DOWN"))

(define (move-left ws)
  (make-worm
   (make-posn
    (- (posn-x (worm-loc ws)) 1)
    (posn-y (worm-loc ws)))
   "LEFT"))

(check-expect (move-left (make-worm (make-posn 10 10) "START"))
              (make-worm (make-posn 9 10) "LEFT"))

(define (move-right ws)
  (make-worm
   (make-posn
    (+ (posn-x (worm-loc ws)) 1)
    (posn-y (worm-loc ws)))
   "RIGHT"))

(check-expect (move-right (make-worm (make-posn 10 10) "START"))
              (make-worm (make-posn 11 10) "RIGHT"))

(define (attention ws ke)
  (cond
    [(key=? ke "up") (move-up ws)]
    [(key=? ke "down") (move-down ws)]
    [(key=? ke "left") (move-left ws)]
    [(key=? ke "right") (move-right ws)]
    [else ws]))

(define (worm-main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [on-key attention]
            ))

(define WORM-START (make-worm (make-posn (/ WIDTH 2) (/ HEIGHT 2)) "START"))

(worm-main WORM-START)
