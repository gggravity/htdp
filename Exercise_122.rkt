;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (f x y)
  (+ (* 3 x) (* y y)))

(+ (f 1 2) (f 2 1))

(f 1 (* 2 3))

(f (f 1 (* 2 3)) 19)
