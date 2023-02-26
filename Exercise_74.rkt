;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

;; Posn -> Image
;; adds a red spot to MTS at p

(check-expect (scene+dot (make-posn 10 20)) (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73)) (place-image DOT 88 73 MTS))

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

;; Posn -> Posn
;; increases the x-coordinate of p by 3

(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))


;; Posn -> Posn
;; increases the x-coordinate of p by 3
;; new version of the above function, should be eq. 
(define (x+new p)
  (posn-up-x p (+ (posn-x p) 3)))

(define p (make-posn 31 26))

;; Posn Number -> Posn
(define (posn-up-x p n)
  (make-posn n (posn-y p)))

;; check if the new verson of x+ with posn-up-x give the same result as the old one.
(check-expect (equal? (x+ p) (x+new p)) #true)

;; Posn Number Number MouseEvt -> Posn
;; for mouse clicks, (make-posn x y); otherwise p

(check-expect (reset-dot (make-posn 10 20) 29 31 "button-down") (make-posn 29 31))
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-up") (make-posn 10 20))

(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))

;; A Posn represents the state of the world.
;; Posn -> Posn
(define (main p0)
  (big-bang p0
            [on-tick x+]
            [on-mouse reset-dot]
            [to-draw scene+dot]))

(main (make-posn 0 50))
