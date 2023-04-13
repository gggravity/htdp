;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

; An Atom is one of:
; – Number
; – String
; – Symbol

(define (atom? value)
  (or (number? value)
      (string? value)
      (symbol? value)))

(define b 123)

(check-expect (atom? 123) #true)
(check-expect (atom? "hello world") #true)
(check-expect (atom? 'a) #true)
(check-expect (atom? b) #true)
(check-expect (atom? '(1 2 3)) #false)
(check-expect (atom? '("hello" "world")) #false)

