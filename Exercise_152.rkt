;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;; Image N -> Number
;; computes put image inside beside 
(define (col img n)
  (if (eq? n 1) img
      (beside img (col img (sub1 n)))))

;; Image N -> Number
;; computes put image inside above 
(define (row img n)
  (if (eq? n 1) img
      (above img (row img (sub1 n)))))

(check-expect (col (circle 10 "solid" "gray") 5)
              (beside (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")))

(check-expect (row (circle 10 "solid" "gray") 5)
              (above (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")))

