;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)


;; movie -> String String Number
;;
;; interpretation:
;; title -> the title of the movie
;; producer -> the producer of the movie
;; year -> the year the movie was released.
(define-struct movie [title producer year])


;; person -> String String String String
;;
;; interpretation:
;; name -> the name of the person
;; hair -> the color of the persons hair
;; eyes -> the color of the persons eyes
;; phone -> the phone number of the person
(define-struct person [name hair eyes phone])

;; pet -> String Number
;;
;; interpretation:
;; name -> the type of pet (ex. Cat)
;; number -> the amount of pets 
(define-struct pet [name number])

;; CD -> String String Number
;;
;; interpretation:
;; artist -> name of the artist
;; title -> title of the album
;; price -> price of the album
(define-struct CD [artist title price])

;; sweater -> String String String
;;
;; interpretation:
;; material -> what material are the sweater made of
;; size -> the size of the sweater (S, M, L, etc.)
;; producer -> Who produced the sweater
(define-struct sweater [material size producer])
