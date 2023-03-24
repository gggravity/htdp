;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; N -> Number
;; computes (+ n pi) without using +

(check-within (add-to-pi 3) (+ 3 pi) 0.001)

(define (add-to-pi n)
  (cond
    [(eq? n 0) pi]
    [else (add1 (add-to-pi (sub1 n)))] ))


;; N -> Number
;; computes (+ n x) without using +
(define (add-to n x)
  (cond
    [(eq? n 0) x]
    [else (add1 (add-to (sub1 n) x))] ))

(check-expect (add-to 0 0) 0)
(check-expect (add-to 0 1) 1)
(check-expect (add-to 1 0) 1)
(check-expect (add-to 3 3) 6)
(check-expect (add-to 9 31) 40)
(check-expect (add-to 31 9) 40)
(check-expect (add-to 1 3) 4)
