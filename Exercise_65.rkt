;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)


;; make-movie, movie?, movie-title, movie-producer, movie-year
(define-struct movie [title producer year])

;; make-person, person?, person-name, person-hair, person-eyes, person-phone
(define-struct person [name hair eyes phone])

;; make-pet, pet?, pet-name, pet-number
(define-struct pet [name number])

;; make-CD, CD?, CD-artist, CD-title, CD-price
(define-struct CD [artist title price])

;; make-sweater, sweater?, sweater-material, sweater-size, sweater-producer
(define-struct sweater [material size producer])