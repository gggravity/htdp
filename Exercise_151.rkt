;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; N -> Number
;; computes (* n1 n2) without using +
(define (multiply n1 n2)
  (if (zero? n2) 0
      (+ n1 (multiply n1 (sub1 n2)))))

(check-expect (multiply 0 0) (* 0 0))
(check-expect (multiply 0 1) (* 0 1))
(check-expect (multiply 1 0) (* 1 0))
(check-expect (multiply 3 3) (* 3 3))
(check-expect (multiply 9 31) (* 9 31))
(check-expect (multiply 31 9) (* 31 9))
(check-expect (multiply 1 3) (* 1 3))


