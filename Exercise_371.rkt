;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

;; An Xexpr is a list: 
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))
;; - (cons Symbol (cons [List-of XWord] Body))

;; where Body is short for [List-of Xexpr]

;; An Attribute is a list of two items:
;; (cons Symbol (cons String '()))

;; An XWord is '(Symbol ((text String))).
