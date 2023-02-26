;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; A Color is one of:
;; --- "white"
;; --- "yellow"
;; --- "orange"
;; --- "green"
;; --- "red"
;; --- "blue"
;; --- "black"
(define-struct Color [color])

(make-Color "blue")

;; happiness is a number:
;; H is a Number between 0 and 100.
;; interpretation represents a happiness value
(define-struct happiness [H])

(make-happiness 100)

;; person -> String String Predicate
;;
;; interpretation:
;; fstname -> first name of the person
;; lstname -> last name of the person
;; male? -> predicate, #t or #f
(define-struct person [fstname lstname male?])

(make-person "Jane" "Doe" #f)

; dog -> Person String Number happiness
;
;; interpretation:
;; owner -> a person structure with the dogs owner
;; name -> the name of the dog
;; age -> the age of the dog (positive integer
;; happiness -> a happiness structure with the dogs happiness (0-100)
(define-struct dog [owner name age happiness])

(make-dog (make-person "James" "Brown" #t) "Fluffy" 10 (make-happiness 100))

;; A Weapon is one of:
;; --- #false
;; --- Posn
;; interpretation #false means the missile hasn't
;; been fired yet; a Posn means it is in flight
(define-struct Weapon [fired_or_position])

(make-Weapon #f)
(make-Weapon (make-posn 12 13))
