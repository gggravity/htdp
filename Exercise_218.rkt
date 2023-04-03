;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define TOCK-SIZE 0.1)

;; dimensions of the scene
(define WIDTH 600)
(define HEIGHT 400)

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

(define SIDE-LENGTH 10)

(define WORM-HEAD (square (- SIDE-LENGTH 1) "solid" "red"))
(define WORM-TAIL (square (- SIDE-LENGTH 1) "solid" "lightred"))
(define WORM-OVER (circle (* SIDE-LENGTH 2) "solid" "red"))

(define-struct worm [head dir tail tocks])
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
;;
;; tocks is the amount of tocks since start



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
                     )
                    0
                    ))

(define WORM-TEST (make-worm
                   (make-posn 300 160)
                   "RIGHT"
                   (list (make-posn 290 160)
                         (make-posn 290 150)
                         (make-posn 300 150)
                         (make-posn 300 160)
                         (make-posn 300 170)
                         (make-posn 300 180))
                   9
                   ))

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
             (if (string=? (worm-dir ws) "START")
                 0
                 (add1 (worm-tocks ws))
                 )))

(define (render-tail tail)
  (if (empty? tail) BACKGROUND
      (place-image
       WORM-TAIL (posn-x (first tail)) (posn-y (first tail))
       (render-tail (rest tail))
       )))

(define (render ws)
  (place-image WORM-HEAD (posn-x (worm-head ws)) (posn-y (worm-head ws))
               (render-tail (worm-tail ws))))

(define (render-game-over-hit-a-wall ws)
  (overlay/align/offset
   "right" "bottom"
   (place-image WORM-OVER (posn-x (worm-head ws)) (posn-y (worm-head ws)) BACKGROUND)
   -10 -10
   (text/font "Worm hit border" 24 "red" "Gill Sans" 'swiss 'normal 'bold #f)
   ))

(define (render-game-over-head-hit-tail ws)
  (overlay/align/offset
   "right" "bottom"
   (place-image WORM-OVER (posn-x (worm-head ws)) (posn-y (worm-head ws)) BACKGROUND)
   -10 -10
   (text/font "Tail hit head" 24 "red" "Gill Sans" 'swiss 'normal 'bold #f)
   ))

(define (render-game-over ws)
  (if (hit-a-wall? ws)
      (render-game-over-hit-a-wall ws)
      (render-game-over-head-hit-tail ws)
      ))

(define (move-up ws)
  (if (or (string=? (worm-dir ws) "UP") (string=? (worm-dir ws) "DOWN")) ws
      (make-worm (worm-head ws) "UP" (worm-tail ws) (worm-tocks ws))))

(define (move-down ws)
  (if (or (string=? (worm-dir ws) "UP") (string=? (worm-dir ws) "DOWN")) ws
      (make-worm (worm-head ws) "DOWN" (worm-tail ws) (worm-tocks ws))))

(define (move-left ws)
  (if (or (string=? (worm-dir ws) "LEFT") (string=? (worm-dir ws) "RIGHT")) ws
      (make-worm (worm-head ws) "LEFT" (worm-tail ws) (worm-tocks ws))))

(define (move-right ws)
  (if (or (string=? (worm-dir ws) "LEFT") (string=? (worm-dir ws) "RIGHT")) ws
      (make-worm (worm-head ws) "RIGHT" (worm-tail ws) (worm-tocks ws))))

(define (attention ws ke)
  (cond
    [(key=? ke "up") (move-up ws)]
    [(key=? ke "down") (move-down ws)]
    [(key=? ke "left") (move-left ws)]
    [(key=? ke "right") (move-right ws)]
    [else ws]))

(define (hit-a-wall? ws)
  (or (or (< (posn-x (worm-head ws)) 0)
          (> (posn-x (worm-head ws)) WIDTH))
      (or (< (posn-y (worm-head ws)) 0)
          (> (posn-y (worm-head ws)) HEIGHT))))

(define (head-hit-tail? ws)
  (and
   (> (worm-tocks ws) (* TOCK-SIZE (length (worm-tail ws))))
   (member (worm-head ws) (worm-tail ws))
   ))

(define (game-over? ws)
  (or (hit-a-wall? ws)
      (head-hit-tail? ws)))

(define (worm-main ws)
  (big-bang ws
            [on-tick tock TOCK-SIZE]
            [to-draw render]
            [on-key attention]
            [stop-when game-over? render-game-over]
            ))

(worm-main WORM-START)

;; (member (worm-head WORM-TEST) (worm-tail WORM-TEST))



