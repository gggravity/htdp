;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; dimensions of the scene
(define WIDTH 100)
(define HEIGHT 100)

;; side length of the square
(define LEN 50)

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

;; the images of the diffence states
(define init-state (overlay
                    (square LEN "outline" "black")
                    (square LEN "solid" "white")))

(define a-state (overlay
                    (square LEN "outline" "black")
                    (square LEN "solid" "yellow")))

(define b-state (overlay
                    (square LEN "outline" "pink")
                    (square LEN "solid" "yellow")))

(define c-state (overlay
                    (square LEN "outline" "green")
                    (square LEN "solid" "yellow")))

(define d-state (overlay
                    (square LEN "outline" "black")
                    (square LEN "solid" "green")))

(define error-state (overlay
                    (square LEN "outline" "black")
                    (square LEN "solid" "red")))

;; render function for the difference states
(define (render state)
  (cond
    [(eq? state "init") (place-image/align init-state 25 25 "left" "top" BACKGROUND)]
    [(eq? state "a") (place-image/align a-state 25 25 "left" "top" BACKGROUND)]
    [(eq? state "b") (place-image/align b-state 25 25 "left" "top" BACKGROUND)]
    [(eq? state "c") (place-image/align c-state 25 25 "left" "top" BACKGROUND)]
    [(eq? state "d") (place-image/align d-state 25 25 "left" "top" BACKGROUND)]
    [(eq? state "error") (place-image/align error-state 25 25 "left" "top" BACKGROUND)]
  ))


;; the on key action for the difference states
(define (change-a state)
  (cond
    [(eq? state "init") "a"]
    [else "error"]))

(define (change-b state)
  (cond
    [(eq? state "a") "b"]
    [(eq? state "b") "b"]
    [(eq? state "c") "b"]
    [else "error"]))

(define (change-c state)
  (cond
    [(eq? state "a") "c"]
    [(eq? state "b") "c"]
    [(eq? state "c") "c"]
    [else "error"]))

(define (change-d state)
  (cond
    [(eq? state "a") "d"]
    [(eq? state "b") "d"]
    [(eq? state "c") "d"]
    [else "error"]))

(define (key-press state ke)
  (cond
    [(key=? ke "a") (change-a state)]
    [(key=? ke "b") (change-b state)]
    [(key=? ke "c") (change-c state)]
    [(key=? ke "d") (change-d state)]
    [(key=? ke "i") "init"]
    [else state]))

;; main function
(define (main state)
  (big-bang state
	    [to-draw render]
	    [on-key key-press]))

(main "init")
