;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

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

;; dimensions of the scene
(define WIDTH 800)
(define HEIGHT 600)

;; the speed of the game
(define speed 3)

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

;; (make-sigs UFO Tank MissileOrNot
;;
;; MissileOrNot is one of:
;; --- #false
;; --- Posn
(define-struct sigs [ufo tank missile])

;; the state when no missiles have in the scene.
;; (define-struct aim [ufo tank])

(define AIM1 (make-sigs (make-posn 20 10)
                        (make-tank 28 -3)
                        #false))


;; the state after a missile have been fired.
;; (define-struct fired[ufo tank missile])

(define FIRED1 (make-sigs (make-posn 20 10)
                          (make-tank 28 -3)
                          (make-posn 28 (- HEIGHT TANK-HEIGHT))))

(define FIRED2 (make-sigs (make-posn 40 100)
                          (make-tank 100 3)
                          (make-posn 30 201)))

(define FIRED3 (make-sigs (make-posn 100 100)
                          (make-tank 100 3)
                          (make-posn 22 201)))

(define START (make-sigs (make-posn (/ WIDTH 2) 0)
                         (make-tank (/ WIDTH 2) HEIGHT)
                         #false))

;; SIGS.v2 -> Image
(define (si-render ws)
  (local ((define missile (sigs-missile ws))
          (define ufo (sigs-ufo ws))
          (define tank (sigs-tank ws))
          ;; UFO Image -> Image
          ;; adds t to the given image im
          (define (ufo-render img)
            (place-image UFO (posn-x ufo) (posn-y ufo) img))
          ;; Tank Image -> Image
          ;; adds t to the given image img
          (define (tank-render img)
            (place-image TANK (tank-loc tank) HEIGHT img))
          ;; Missile Image -> Image
          ;; adds m to the given image img
          (define (missile-render img)
            (if  (boolean? missile) img
                 (place-image MISSILE (posn-x missile) (posn-y missile) img))))
    
    (tank-render (ufo-render (missile-render BACKGROUND)))))

;; the game over function
(define (si-game-over? ws)
  (local ((define ufo (sigs-ufo ws))
          (define missile (sigs-missile ws))
          (define huw (/ (image-width UFO) 2))
          (define ufo-hit?
            (and (not (boolean? missile))
                 (and  (> (+ (posn-y ufo) (image-height UFO)) (posn-y missile))
                       (and  (< (- (posn-x ufo) huw) (posn-x missile))
                             (> (+ (posn-x ufo) huw) (posn-x missile))))))
          ;; check if the ufo have landed
          (define ufo-landed? (>= (posn-y ufo) HEIGHT)))
    
    (or ufo-landed? ufo-hit?)))

;; function defining how the objects move at every tick.
(define (si-move ws)
  (local ((define missile (sigs-missile ws))
          (define ufo (sigs-ufo ws))
          (define tank (sigs-tank ws))
          (define random-value
            (* (if (= (random 2) 0) -1 1) (random 10)))
          ;; how the ufo moves
          (define move-ufo
            (make-posn (+ (posn-x ufo) random-value) (+ (posn-y ufo) speed)))
          ;; how the missile moves
          (define move-missile
            (if (boolean? missile) missile
                (make-posn (posn-x missile) (- (posn-y missile) speed)))))
          
    (make-sigs move-ufo tank move-missile)))

;; function to control the keyevents
(define (si-control ws ke)
  (local ((define missile (sigs-missile ws))
          (define ufo (sigs-ufo ws))
          (define tank (sigs-tank ws))
          ;; function to move the tank left or right
          (define (move ws dir)
            (local ((define move-tank
                      (if (eq? dir "-")
                          (- (tank-loc tank) 10)
                          (+ (tank-loc tank) 10)))
                    (define (create-sigs missile)
                      (make-sigs ufo (make-tank move-tank (tank-vel tank)) missile)))
              (if (boolean? missile) (create-sigs #false) (create-sigs missile))))

          ;; function to fire a missile from the tank
          (define (fire-missile ws)
            (make-sigs ufo tank (make-posn (tank-loc tank) HEIGHT))))

    (cond [(key=? ke "left") (move ws "-")]
          [(key=? ke "right") (move ws "+")]
          [(key=? ke " ") (fire-missile ws)]
          [else ws])
    ))

;; the main loop of the program
(define (main world-state)
  (big-bang world-state
            [on-tick si-move]
            [to-draw si-render]
            [on-key si-control]
            [stop-when si-game-over?]
            ))

;; run the main loop
(main START)
;; (main AIM1)
;; (main FIRED1)
;; (main FIRED2)
;; (main FIRED3)
