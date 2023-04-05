;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; A [Maybe X] is one of:
; – #false
; – X

; A [Maybe String] is one of:
; – #false
; – String
; interpretation #false or a string

; A [Maybe [List-of String]] is one of:
; – #false
; – (cons String '())
; interpretation #false or a a list of strings

; A [List-of [Maybe String]] is one of:
; (cons [Maybe String] '())
; interpretation a list of #false or strings
