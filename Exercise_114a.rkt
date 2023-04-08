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

;; dimensions of the scene
(define WIDTH 800)
(define HEIGHT 600)

;; the speed of the game
(define speed 3)

;; how the ufo should look like
(define UFO (overlay (circle 10 "solid" "orange") (ellipse 40 7 "outline" "green")))

(define half-ufo-width (/ (image-width UFO) 2))

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

;; Missile Image -> Image
;; adds m to the given image img
(define (missile-render m img)
  (cond
    [(boolean? m) img]
    [(posn? m) (place-image MISSILE (posn-x m) (posn-y m) img)]))

;; Tank Image -> Image
;; adds t to the given image img
(define (tank-render t img)
  (place-image TANK (tank-loc t) HEIGHT img))

;; UFO Image -> Image
;; adds t to the given image im
(define (ufo-render u img)
  (place-image UFO (posn-x u) (posn-y u) img))

;; SIGS.v2 -> Image
(define (si-render s)
  (tank-render
   (sigs-tank s)
   (ufo-render (sigs-ufo s)
               (missile-render (sigs-missile s)
                                  BACKGROUND))))

;; check if the ufo have landed
(define (ufo-landed? ufo)
  (>= (posn-y ufo) HEIGHT))

(check-expect (ufo-landed? (make-posn 0 0)) #false)
(check-expect (ufo-landed? (make-posn 0 HEIGHT)) #true)
(check-expect (ufo-landed? (make-posn 0 (+ HEIGHT 100))) #true)

(define (ufo-hit? ufo missile)
  (and
   (> (+ (posn-y ufo) (image-height UFO)) (posn-y missile))
   (and
    (< (- (posn-x ufo) half-ufo-width) (posn-x missile))
    (> (+ (posn-x ufo) half-ufo-width) (posn-x missile)))))

;; the game over function
(define (si-game-over? ws)
  (cond
    [(boolean? (sigs-missile ws)) #false]
    [else (or (ufo-landed? (sigs-ufo ws))
              (ufo-hit? (sigs-ufo ws) (sigs-missile ws)))]
    ))

;; how the ufo moves
(define (move-ufo ufo)
  (make-posn ( + (posn-x ufo)
                 (* (if (= (random 2) 0) -1 1)
                 (random 10))
                 )
             (+ (posn-y ufo) speed)))

;; how the missile moves
(define (move-missile missile)
  (make-posn (posn-x missile) (- (posn-y missile) speed)))

;; function defining how the objects move at every tick.
(define (si-move ws)
  (cond
    [(boolean? (sigs-missile ws)) (make-sigs
                                   (move-ufo (sigs-ufo ws))
                                   (sigs-tank ws)
                                   #false)]
    [else (make-sigs (move-ufo (sigs-ufo ws))
                     (sigs-tank ws)
                     (move-missile (sigs-missile ws)))]))

;; function to control the keyevents
(define (si-control ws ke)
  (cond [(key=? ke "left") (move ws "-")]
        [(key=? ke "right") (move ws "+")]
        [(key=? ke " ") (fire-missile ws)]
        [else ws]))

;; function to move the tank left or right
(define (move ws dir)
  (cond
    [(boolean? (sigs-missile ws))
     (make-sigs
      (sigs-ufo ws)
      (make-tank
       (cond
         [(eq? dir "-")
          (- (tank-loc (sigs-tank ws)) 10)]
         [else (+ (tank-loc (sigs-tank ws)) 10)])
       (tank-vel (sigs-tank ws))
       )
      #false
      )] ; ufo tank
    [else
     (make-sigs
      (sigs-ufo ws)
      (make-tank
       (cond
         [(eq? dir "-")
          (- (tank-loc (sigs-tank ws)) 10)]
         [else (+ (tank-loc (sigs-tank ws)) 10)])
       (tank-vel (sigs-tank ws)))
      (sigs-missile ws))]))

;; function to fire a missile from the tank
(define (fire-missile ws)
  (make-sigs
   (sigs-ufo ws)
   (sigs-tank ws)
   (make-posn (tank-loc (sigs-tank ws)) HEIGHT)))


;; a SIGS (space invader game scene) is one of:
;; --- (make-aim UFO Tank)
;; --- (make-fired UFO Tank Missile)
;; interpretation: represents the complete state of a
;; space invader game.
(define (sigs-or-not? a)
  (cond
    [(sigs? a) #true]
    [else #false]))

(check-expect (sigs-or-not? FIRED1) #true)
(check-expect (sigs-or-not? FIRED2) #true)
(check-expect (sigs-or-not? FIRED3) #true)
(check-expect (sigs-or-not? AIM1) #true)
(check-expect (sigs-or-not? UFO) #false)

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
