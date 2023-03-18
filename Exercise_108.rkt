;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; color is one of RED or GREEN
;; countdown is a bool, representer wither or not the countdown is taking place.
;; cnt is a number
(define-struct world-state [color countdown cnt])

;; dimensions of the scene
(define WIDTH 50)
(define HEIGHT 50)

;; location of the bitmaps
(define red-light (bitmap "images/pedestrian_traffic_light_red.png"))
(define green-light (bitmap "images/pedestrian_traffic_light_green.png"))

(define (display-countdown number)
  (cond 
    [(= number 10) (text "9" 40 "orange")]
    [(= number 11) (text "8" 40 "green")]
    [(= number 12) (text "7" 40 "orange")]
    [(= number 13) (text "6" 40 "green")]
    [(= number 14) (text "5" 40 "orange")]
    [(= number 15) (text "4" 40 "green")]
    [(= number 16) (text "3" 40 "orange")]
    [(= number 17) (text "2" 40 "green")]
    [(= number 18) (text "1" 40 "orange")]
    [(= number 19) (text "0" 40 "green")]))

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "black"))

(define (tock state)
  (cond
    [(eq? (world-state-color state) "RED") state]
    [(= (world-state-cnt state) 9)
     (make-world-state
      (world-state-color state)
      #true
      (+ (world-state-cnt state) 1)
      )]
    [(= (world-state-cnt state) 19)
     (make-world-state "RED" #false 0)]
    [(eq? (world-state-color state) "GREEN")
     (make-world-state
      (world-state-color state)
      (world-state-countdown state)
      (+ (world-state-cnt state) 1)
      )]))

(define (render state)
  (cond
    [(eq? (world-state-color state) "RED")
     (place-image/align red-light 0 0 "left" "top" BACKGROUND)]
    [(world-state-countdown state)
     (place-image/align (display-countdown (world-state-cnt state)) 0 0 "left" "top" BACKGROUND)]
    [(eq? (world-state-color state) "GREEN")
     (place-image/align green-light 0 0 "left" "top" BACKGROUND)]))

(define (go state)
  (cond
    [(eq? (world-state-color state) "RED") (make-world-state "GREEN" #false 1)]
    [else state]))

(define (attention state ke)
  (cond
    [(key=? ke " ") (go state)]
    [else state]))

(define (main state)
  (big-bang state
	    [on-tick tock 0.5]
	    [to-draw render]
	    [on-key attention]))

(main (make-world-state "RED" #false 0))
