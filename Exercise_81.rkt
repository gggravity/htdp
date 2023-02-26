;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Design the function time->seconds, which consumes instances
;; of time structures (see exercise 77) and produces the number of seconds that
;; have passed since midnight. For example, if you are representing 12 hours, 30
;; minutes, and 2 seconds with one of these structures and if you then apply time-
;; >seconds to this instance, the correct result is 45002.

;; time-since-midnight -> Number Number Number
;;
;; interpretation:
;; hours -> hours since midnight as integer value
;; minutes -> minutes since last hour as integer value
;; seconds -> seconds since last minute as integer value
(define-struct time-since-midnight [hours minutes seconds])


;; time-since-midnight -> Number
;; return number of sec since midnight from a time-since-midnight struct

(check-expect (time->seconds (make-time-since-midnight 0 0 0)) 0)
(check-expect (time->seconds (make-time-since-midnight 12 30 2)) 45002)

(define (time->seconds t)
  (+ (* (time-since-midnight-hours t) 3600)
     (* (time-since-midnight-minutes t) 60)
     (time-since-midnight-seconds t)))

(time->seconds (make-time-since-midnight 1 23 4))
