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

(define SIDE-LENGTH 10)

(define WORM-HEAD (square (- SIDE-LENGTH 1) "solid" "red"))
(define WORM-TAIL (square (- SIDE-LENGTH 1) "solid" "lightred"))
(define WORM-OVER (circle (* SIDE-LENGTH 2) "solid" "red"))

(define-struct worm [head dir tail])
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
;;
;; tail is a list of posn

(define WORM-START (make-worm
                    (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                    "START"
                    (list
                     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                     )))


(define (move-head head dir)
  (cond
    [(string=? dir "UP") (make-posn (posn-x head) (- (posn-y head) SIDE-LENGTH))]
    [(string=? dir "DOWN") (make-posn (posn-x head) (+ (posn-y head) SIDE-LENGTH))]
    [(string=? dir "LEFT") (make-posn (- (posn-x head) SIDE-LENGTH) (posn-y head))]
    [(string=? dir "RIGHT") (make-posn (+ (posn-x head) SIDE-LENGTH) (posn-y head))]
    [else head]
    ))

(define (move-tail head tail)
  (if (empty? tail) '()
      (cons head (move-tail (first tail) (rest tail)))
      ))

(define (tock ws)
  (make-worm (move-head (worm-head ws) (worm-dir ws))
             (worm-dir ws)
             (move-tail (worm-head ws) (worm-tail ws))
             ))

(define (render-tail tail)
  (if (empty? tail) BACKGROUND
      (place-image
       WORM-TAIL (posn-x (first tail)) (posn-y (first tail))
       (render-tail (rest tail))
       )))

(define (render ws)
  (place-image WORM-HEAD (posn-x (worm-head ws)) (posn-y (worm-head ws))
               (render-tail (worm-tail ws))))

(define (render-game-over ws)
  (overlay/align/offset
   "right" "bottom"
   (place-image WORM-OVER (posn-x (worm-head ws)) (posn-y (worm-head ws)) BACKGROUND)
   -10 -10
   (text/font "worm hit border" 24 "red" "Gill Sans" 'swiss 'normal 'bold #f)
   ))

(define (move-up ws)
  (if (or (string=? (worm-dir ws) "UP") (string=? (worm-dir ws) "DOWN")) ws
      (make-worm (worm-head ws) "UP" (worm-tail ws))))

(check-expect (move-up (make-worm (make-posn 10 10) "START" (list)))
              (make-worm (make-posn 10 9) "UP" (list)))

(define (move-down ws)
  (if (or (string=? (worm-dir ws) "UP") (string=? (worm-dir ws) "DOWN")) ws
      (make-worm (worm-head ws) "DOWN" (worm-tail ws))))

(check-expect (move-down (make-worm (make-posn 10 10) "START" (list)))
              (make-worm (make-posn 10 11) "DOWN" (list)))

(define (move-left ws)
  (if (or (string=? (worm-dir ws) "LEFT") (string=? (worm-dir ws) "RIGHT")) ws
      (make-worm (worm-head ws) "LEFT" (worm-tail ws))))

(check-expect (move-left (make-worm (make-posn 10 10) "START" (list)))
              (make-worm (make-posn 9 10) "LEFT" (list)))

(define (move-right ws)
  (if (or (string=? (worm-dir ws) "LEFT") (string=? (worm-dir ws) "RIGHT")) ws
      (make-worm (worm-head ws) "RIGHT" (worm-tail ws))))

(check-expect (move-right (make-worm (make-posn 10 10) "START" (list)))
              (make-worm (make-posn 11 10) "RIGHT" (list)))

(define (attention ws ke)
  (cond
    [(key=? ke "up") (move-up ws)]
    [(key=? ke "down") (move-down ws)]
    [(key=? ke "left") (move-left ws)]
    [(key=? ke "right") (move-right ws)]
    [else ws]))

(define (game-over? ws)
  (or (or (< (posn-x (worm-head ws)) 0)
          (> (posn-x (worm-head ws)) WIDTH))
      (or (< (posn-y (worm-head ws)) 0)
          (> (posn-y (worm-head ws)) HEIGHT))))

(define (worm-main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [on-key attention]
            [stop-when game-over? render-game-over]
            ))

(worm-main WORM-START)
