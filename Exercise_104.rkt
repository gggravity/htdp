;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; structure for vehicles
;;   (make-vehicle Type Number String Number)
;;
;; Type is one of:
;; "automobile"
;; "van"
;; "bus"
;; "SUV"

(define-struct vehicle [type passengers license-plate fuel-consumption])

(make-vehicle "automobile" 4 "123-XXX-123" 4)
(make-vehicle "van" 8 "321-YEY-123" 6)
(make-vehicle "bus" 40 "555-BUS-111" 20)
(make-vehicle "SUV" 6 "111-WWW-111" 8)

