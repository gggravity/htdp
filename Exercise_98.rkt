;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; a UFO is a Posn
;; interpretation (make-posn x y) is the UFO's location
;; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
;; a Tank is a structure:
;;    (make-tank x dx) specifies the position:
;; (x, HEIGHT) and the tank's speed: dx pixels/tick.


;; A Missile is a Posn
;; interpretation (make-posn x y) is the missile's place

;; a SIGS (space invader game scene) is one of:
;; --- (make-aim UFO Tank)
;; --- (make-fired UFO Tank Missile)
;; interpretation: represents the complete state of a
;; space invader game.

;; dimensions of the scene
(define WIDTH 800)
(define HEIGHT 600)

;; how the ufo should look like
(define UFO (overlay (circle 10 "solid" "orange") (ellipse 40 7 "outline" "green")))

;; how the tank should look like
(define TANK-HEIGHT 30)
(define TANK-WIDTH 100)
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "darkgreen"))

;; how the missile should look like
(define MISSILE (rectangle 5 20 "solid" "black"))

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "lightblue"))

;; the state when no missiles have in the scene.
(define-struct aim [ufo tank])

(define AIM1 (make-aim (make-posn 20 10)
                       (make-tank 28 -3)))


;; the state after a missile have been fired.
(define-struct fired[ufo tank missile])

(define FIRED1 (make-fired (make-posn 20 10)
                           (make-tank 28 -3)
                           (make-posn 28 (- HEIGHT TANK-HEIGHT))))

(define FIRED2 (make-fired (make-posn 20 100)
                           (make-tank 100 3)
                           (make-posn 22 201)))

;; what to change on every tick
(define(tock state)
  state)

;; Missile Image -> Image
;; adds m to the given image img
(define (missile-render m img)
  (place-image MISSILE (posn-x m) (posn-y m) img))

;; Tank Image -> Image
;; adds t to the given image img
(define (tank-render t img)
  (place-image TANK (tank-loc t) HEIGHT img))

;; UFO Image -> Image
;; adds t to the given image im
(define (ufo-render u img)
  (place-image UFO (posn-x u) (posn-y u) img))

;; SIGS -> Image
;; adds TANK, UFO, and possibly MISSILE to the BACKGROUND scene
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missile-render (fired-missile s)
                                  BACKGROUND)))]))

;; function to move the tank left
(define (move-left ws)
  ws)

;; function to move the tank right
(define (move-right ws)
  ws)

;; check if the ufo have landed
(define (ufo-landed? ufo)
  (>= (posn-y ufo) HEIGHT))

(check-expect (ufo-landed? (make-posn 0 0)) #false)
(check-expect (ufo-landed? (make-posn 0 HEIGHT)) #true)
(check-expect (ufo-landed? (make-posn 0 (+ HEIGHT 100))) #true)

(define (ufo-hit? ufo missile)
  (and (eq? (posn-x ufo) (posn-x missile))
       (eq? (posn-y ufo) (posn-y missile))))

(check-expect (ufo-hit? (make-posn 0 0) (make-posn 0 0)) #true)
(check-expect (ufo-hit? (make-posn 10 0) (make-posn 10 1)) #false)
(check-expect (ufo-hit? (make-posn 1 10) (make-posn 1 11)) #false)

;; the game over function
(define (si-game-over? ws)
  (cond
    [(aim? ws) (ufo-landed? (aim-ufo ws))]
    [(fired? ws) (or (ufo-landed? (fired-ufo ws))
                     (ufo-hit? (fired-ufo ws) (fired-missile ws))
                     )]
    [else #false]))

;; function to fire a missile from the tank
(define (fire-missile ws)
 ws)

;; What function to run on difference key presses
(define (key-pressed ws ke)
  (cond [(key=? ke "left") (move-left ws)]
        [(key=? ke "right") (move-right ws)]
        [(key=? ke " ") (fire-missile ws)]
        [else ws]))

;; the main loop of the program
(define (main world-state)
  (big-bang world-state
	    [on-tick tock]
	    [to-draw si-render]
	    [on-key key-pressed]
            [stop-when si-game-over?]
            ))

;; run the main loop
;; (main AIM1)
;; (main FIRED1)
;; (main FIRED2)
