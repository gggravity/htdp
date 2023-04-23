;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

;; An Attribute is a list of two items:
;; (cons Symbol (cons String '()))

;; An Xexpr is a list: 
;; – (cons Symbol [List-of Xexpr])
;; – (cons Symbol (cons [List-of Attribute] [List-of Xexpr]))


;; <transition from="seen-e" to="seen-f" />

;; <ul><li><word /><word /></li><li><word /></li></ul>


'(transition ((from "seen-e") (to "seen-f")))

'(ul (li (word) word) (li (word)))
