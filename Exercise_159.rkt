;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define-struct pair [balloon# lob])
;; A Pair is a structure (make-pair N List-of-posns)
;; A List-of-posns is one of:
;; --- '()
;; --- (cons Posn List-of-posns)
;; Interpretation (make-pair n lob) means n balloons
;; must yet be thrown and added to lob


;; Image N -> Number
;; computes put image inside beside 
(define (col img n)
  (if (eq? n 1) img
      (beside img (col img (sub1 n)))))

;; Image N -> Number
;; computes put image inside above 
(define (row img n)
  (if (eq? n 1) img
      (above img (row img (sub1 n)))))

(define WIDTH 80)
(define HEIGTH 180)

(define lecture-hall (row (col (square 10 "solid" "navy") 8) 18))

(define background (place-image/align lecture-hall 0 0 "left" "top" (empty-scene WIDTH HEIGTH)))

(define c (circle 5 "solid" "red"))

(define (add-balloons l img)
  (if (empty? l) img
      (place-image c (posn-x (first l)) (posn-y (first l))
                   (add-balloons (rest l) img))))

(define (render w)
  (add-balloons (pair-lob w) background))

(define (tock w)
  (cond
    [(zero? (pair-balloon# w)) w]
    [else (make-pair (sub1 (pair-balloon# w))
                     (cons (make-posn (random WIDTH) (random HEIGTH)) (pair-lob w)))]))

(define (riot scene)
  (big-bang scene
            (on-tick tock)
            (to-draw render)
            ))

(riot (make-pair 300 '()))
