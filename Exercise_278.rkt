;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define TOCK-SIZE 0.05)

;; dimensions of the scene
(define WIDTH 600)
(define HEIGHT 400)

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))
(define SIDE-LENGTH 11)
(define-struct worm [head dir tail tocks food score])
;; head is a posn for the worms head
;;
;; dir is the direction of the worm
;; dir is one of:
;; UP
;; DOWN
;; LEFT
;; RIGHT
;; START (no movement, used for the start position)
;;
;; tail is a list of posn, one for each tail segment
;;
;; tocks is the amount of ticks since start
;;
;; score is the score of the player, set it to 0 for new games
;; it's increased when the worm eats.

(define (food-create p)
  (food-check-create
   p (make-posn (random WIDTH) (random HEIGHT))))

(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))

(define WORM-START
  (make-worm
   (make-posn (/ WIDTH 2) (/ HEIGHT 2))
   "START"
   (list (make-posn 0 0))
   0
   (food-create (make-posn 0 0))
   0))

(define (tock ws)
  (local ((define head (worm-head ws))
          (define dir (worm-dir ws))
          (define tail (worm-tail ws))
          (define tocks (worm-tocks ws))
          (define food (worm-food ws))
          (define score (worm-score ws))
          (define add-to-tocks (if (string=? dir "START") 0 (add1 tocks)))
          (define move-head
            (local ((define head-up
                      (make-posn (posn-x head) (- (posn-y head) SIDE-LENGTH)))
                    (define head-down
                      (make-posn (posn-x head) (+ (posn-y head) SIDE-LENGTH)))
                    (define head-left
                      (make-posn (- (posn-x head) SIDE-LENGTH) (posn-y head)))
                    (define head-right
                      (make-posn (+ (posn-x head) SIDE-LENGTH) (posn-y head))))
              (cond
                [(string=? dir "UP") head-up]
                [(string=? dir "DOWN") head-down]
                [(string=? dir "LEFT") head-left]
                [(string=? dir "RIGHT") head-right]
                [else head])))
          (define (move-tail head tail)
            (if (empty? tail) '()
                (cons head (move-tail (first tail) (rest tail)))))
          (define tick
            (make-worm
             move-head
             dir
             (move-tail head tail)
             add-to-tocks
             food
             score))
          (define eat
            (make-worm
             move-head
             dir
             (move-tail head (append tail (list (make-posn 0 0))))
             add-to-tocks
             (food-create (make-posn 0 0))
             (add1 score)))
          (define eating
            (local ((define distance-head-food
                      (sqrt (+ (sqr (- (posn-y head) (posn-y food)))
                               (sqr (- (posn-x head) (posn-x food)))))))
              (> SIDE-LENGTH distance-head-food))))
    (if eating eat tick)))

(define (render ws)
  (local ((define WORM-HEAD (square (- SIDE-LENGTH 1) "solid" "red"))
          (define WORM-TAIL (square (- SIDE-LENGTH 1) "solid" "lightred"))
          (define FOOD (circle (/ SIDE-LENGTH 2) "solid" "green"))
          (define head (worm-head ws))
          (define tail (worm-tail ws))
          (define food (worm-food ws))
          (define score (worm-score ws))
          (define score-text
            (string-append "Score: " (number->string score)))
          (define (place-tail t img)
            (place-image WORM-TAIL (posn-x t) (posn-y t) img))
          (define (place-head t img)
            (place-image WORM-HEAD (posn-x t) (posn-y t) img))
          (define (place-food t img)
            (place-image FOOD (posn-x t) (posn-y t) img))
          (define (render-tail tail)
            (foldl place-tail BACKGROUND tail))
          (define render-head
            (foldl place-head (render-tail tail) (list head)))
          (define render-food
            (foldl place-food render-head (list food)))
          (define render-scene
            (underlay/align/offset
             "left" "top"
             (text/font score-text 24 "lightgray" "Gill Sans" 'swiss 'normal 'bold #f)
             -5 -5
             render-food)))
    render-scene))

(define (render-game-over ws)
  (local ((define worm (circle (* SIDE-LENGTH 2) "solid" "red"))
          (define head (worm-head ws))
          (define (render text)
            (overlay/align/offset
             "right" "bottom"
             (place-image worm (posn-x head) (posn-y head) BACKGROUND)
             -10 -10 (text/font text 24 "red" "Gill Sans" 'swiss 'normal 'bold #f)))
          )
    (if (hit-a-wall? ws)
        (render "Worm hit border")
        (render "Tail hit head")
        )))

(define (attention ws ke)
  (local (
          (define direction (worm-dir ws))
          (define vertical (or (string=? direction "UP")
                               (string=? direction "DOWN")))
          (define horizontal (or (string=? direction "LEFT")
                                 (string=? direction "RIGHT")))
          (define (move-worm new-direction)
            (make-worm
             (worm-head ws)
             new-direction
             (worm-tail ws)
             (worm-tocks ws)
             (worm-food ws)
             (worm-score ws))))
    (cond
      [(key=? ke "up") (if vertical ws (move-worm "UP"))]
      [(key=? ke "down") (if vertical ws (move-worm "DOWN"))]
      [(key=? ke "left") (if horizontal ws (move-worm "LEFT"))]
      [(key=? ke "right") (if horizontal ws (move-worm "RIGHT"))]
      [else ws])))

(define (hit-a-wall? ws)
  (local ((define head (worm-head ws)))
    (or (or (< (posn-x head) 0)
            (> (posn-x head) WIDTH))
        (or (< (posn-y head) 0)
            (> (posn-y head) HEIGHT)))))

(define (head-hit-tail? ws)
  (local ((define head (worm-head ws))
          (define tail (worm-tail ws))
          (define tocks (worm-tocks ws)))
    (and (> tocks (* TOCK-SIZE (length tail)))
         (member head tail))))

(define (game-over? ws)
  (or (hit-a-wall? ws)
      (head-hit-tail? ws)))

(define (worm-main ws)
  (big-bang ws
            [on-tick tock TOCK-SIZE]
            [to-draw render]
            [on-key attention]
            [stop-when game-over? render-game-over]))

(worm-main WORM-START)
