;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define p1 (make-posn 3 4))


;; Posn -> Number
;; return the manhattan distance of a point

(check-expect (manhattan-distance (make-posn 3 4)) 7)
(check-expect (manhattan-distance (make-posn 8 6)) 14)
(check-expect (manhattan-distance (make-posn 5 12)) 17)

(define (manhattan-distance ap)
  (+ (posn-x ap) (posn-y ap)))

(manhattan-distance p1)
