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

(define (create-time n)
  (list "Total Time" n))

(define (create-year n)
  (list "year" n))

(define (create-play# d)
  (list "play#" d))

(define (create-is-movie b)
  (list "is-movie" b))

(define TRACK1
  (list
   (create-name "Cry me a river")
   (create-artist "James Brown")
   (create-album "The best of JB")
   (create-time 123456)
   (create-year 2020)
   (create-play# (create-date 2020 12 01 01 01 01))
   (create-is-movie #false)
   ))

(define TRACK2
  (list
   (create-name "BOB's Universe")
   (create-artist "BOB")
   (create-album "The best of BOB")
   (create-time 654321)
   (create-year 2000)
   (create-play# (create-date 2010 10 10 01 01 01))
   (create-is-movie #true)
   ))

(define LIST-OF-TRACKS (list TRACK1 TRACK2))

(define (find-association key asso default)
  (if (empty? asso) (string-append key " " default)
      (if (string=? key (first (first asso)))
          (list key (second (first asso)))
          (find-association key (rest asso) default))
      ))

(check-expect (find-association "name" TRACK1 "not found") (list "name" "Cry me a river"))
(check-expect (find-association "name1" TRACK1 "not found") "name1 not found")
(check-expect (find-association "year" TRACK1 "not found") (list "year" 2020))

(define (total-time/list l)
  (if
   (empty? l)
   0
   (+ (second (find-association "Total Time" (first l) "not found")) (total-time/list (rest l)))
   ))

(check-expect (total-time/list LIST-OF-TRACKS) 777777)

(check-expect (total-time/list list-tracks) 53266664)

(define (find-boolean l)
  (if (empty? l) (list)
      (if (boolean? (second (first l)))
          (first l)
          (find-boolean (rest l)))
      ))

(check-expect (find-boolean (first LIST-OF-TRACKS)) (list "is-movie" #false))
(check-expect (find-boolean (second LIST-OF-TRACKS)) (list "is-movie" #true))
(check-expect (find-boolean (list)) (list))


(define (boolean-attributes l)
  (if (empty? l) (list)
      (cons (find-boolean (first l)) (boolean-attributes (rest l)))
      ))

(check-expect (boolean-attributes LIST-OF-TRACKS)
              (list (list "is-movie" #false)
                    (list "is-movie" #true)))

(boolean-attributes list-tracks)
