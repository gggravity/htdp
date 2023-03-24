;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; N String -> List-of-strings
;; creates a list of n copies of s

(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
(check-expect (copier 1 0.1) (cons 0.1'()))
(check-expect (copier 1 "x") (cons "x" '()))

(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))


;; N String -> List-of-strings
;; creates a list of n copies of s

(check-expect (copier.v2 0 "hello") '())
(check-expect (copier.v2 2 "hello")
              (cons "hello" (cons "hello" '())))
(check-expect (copier.v2 1 0.1) (cons 0.1'()))
(check-expect (copier.v2 1 "x") (cons "x" '()))

(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s ))]))
