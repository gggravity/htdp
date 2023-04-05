;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define-struct layer [stuff])

; An LStr is one of: 
; – String
; – (make-layer LStr)

(make-layer "acb")
(make-layer (make-layer "acb"))

; An LNum is one of: 
; – Number
; – (make-layer LNum)

(make-layer 1)
(make-layer (make-layer 1))

; An [Layer TYPE] is one of: 
; – TYPE
; – (make-layer TYPE)
