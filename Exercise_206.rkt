;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/batch-io)
(require 2htdp/itunes)

; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")

; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

;; LList
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))

; An Association is a list of two items:
; (cons String (cons BSDN '()))

; A BSDN is one of:
; - Boolean
; - Number
; - String
; - Date

(define (create-name str)
  (list "name" str))

(define (create-artist str)
  (list "artist" str))

(define (create-album str)
  (list "album" str))

(define (create-year n)
  (list "year" n))

(define (create-play# d)
  (list "play#" d))

(define TRACK1
  (list
   (create-name "Cry me a river")
   (create-artist "James Brown")
   (create-album "The best of JB")
   (create-year 2020)
   (create-play# (create-date 2020 12 01 01 01 01))
   ))

(define TRACK2
  (list
   (create-name "BOB's Universe")
   (create-artist "BOB")
   (create-album "The best of BOB")
   (create-year 2000)
   (create-play# (create-date 2010 10 10 01 01 01))
   ))

(define LIST-OF-TRACKS (list TRACK1 TRACK2))

(define (find-association key asso default)
  (if (empty? asso) (string-append key " " default)
      (if (string=? key (first (first asso)))
          (second (first asso))
          (find-association key (rest asso) default))
      ))

(check-expect (find-association "name" TRACK1 "not found") "Cry me a river")
(check-expect (find-association "name1" TRACK1 "not found") "name1 not found")
(check-expect (find-association "year" TRACK1 "not found") 2020)
