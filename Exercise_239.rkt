;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; A [List X Y] is a structure: 
;; (cons X (cons Y '()))


;; A [List Number Number] is a structure:
;;   (cons Number (cons Number '())

'(1 2)

;; A [List Number 1String] is a structure:
;;   (cons Number (cons 1String '())

'(1 "1")

;; A [List String Boolean] is a structure:
;;   (cons Number (cons Boolean '())

'(1 #true)
