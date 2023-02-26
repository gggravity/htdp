;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; time-since-midnight -> Number Number Number
;;
;; interpretation:
;; hours -> hours since midnight as integer value
;; minutes -> minutes since last hour as integer value
;; seconds -> seconds since last minute as integer value
(define-struct time-since-midnight [hours minutes seconds])

(define tsm (make-time-since-midnight 11 11 11))

(time-since-midnight-hours tsm)
(time-since-midnight-minutes tsm)
(time-since-midnight-seconds tsm)
