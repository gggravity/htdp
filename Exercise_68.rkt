;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define SPEED 3)
(define-struct balld [location direction])

(make-balld 10 "up")
(make-balld 20 "down")

(define-struct vel [deltax deltay])
(define-struct ball [location velocity])

(define-struct  ballf [x y deltax deltay])

(define ball1 (make-ball (make-posn 30 40) (make-vel -10 5)))

;; Create an instance of ballf that has
;; the same interpretation as ball1.

(make-ballf 30 40 -10 5)
(vel-deltax (ball-velocity ball1))
