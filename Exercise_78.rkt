;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 78. Provide a structure type and a data definition for representing
;; three-letter words. A word consists of lowercase letters, represented with the
;; 1Strings "a" through "z" plus #false. Note This exercise is a part of the design
;; of a hangman game; see exercise 396.

;; three-letter-word -> 1Strings 1Strings 1Strings
;;
;; requirement: 1Strings "a" through "z" plus #false.
;;
;; interpretation:
;; letter1 -> first letter of the word
;; letter2 -> second letter of the word
;; letter3 -> third letter of the word
(define-struct three-letter-word [letter1 letter2 letter3])

(define abc (make-three-letter-word "a" "b" "c"))

(three-letter-word-letter1 abc)
(three-letter-word-letter2 abc)
(three-letter-word-letter3 abc)
