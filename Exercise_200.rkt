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

(define date1 (create-date 2020 12 01 01 01 01))
(define date2 (create-date 1911 11 11 11 11 11))

(define track1 (create-track "My song" "Joe Doe" "First album" 60 6 date1 666 date2))
(define track2 (create-track "Sing along" "Jane Doe" "Rythems" 90 12 date2 123 date1))


(define (total-time lot)
  (if (empty? lot) 0
      (+ (track-time (first lot))
         (total-time (rest lot)))
      ))

(check-expect (total-time (list track1 track2)) 150)

(check-expect (total-time itunes-tracks) 23900585)
