;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_40) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; WorldState -> WorldState
; moves the car by 3 pixels for every clock tick

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

; examples:
; given: 20, expect 23
; given: 78, expect 81
(define(tock ws)
  (+ ws 3))