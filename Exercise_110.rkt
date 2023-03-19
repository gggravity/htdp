;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Number -> Number
;; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

;; Any -> Number
;; computes the area of a disk with radius v,
;; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(number? v)
     (cond
       [(> v 0) (area-of-disk v)]
       [else (error "area-of-disk: radius is negative")])]
    [else (error "area-of-disk: number expected")]))

(checked-area-of-disk "3")
