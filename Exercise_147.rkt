;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (all-true l)
  (cond
    [(empty? (rest l)) (first l)]
    [(cons? l) (and (first l) (all-true (rest l)))]
    [else #false]))

(check-error (all-true '() ) "rest: expects a non-empty list; given: '()")
(check-expect (all-true (cons #true '()) ) #true)
(check-expect (all-true (cons #false '()) ) #false)
(check-expect (all-true (cons #true (cons #true (cons #true '() )))) #true)
(check-expect (all-true (cons #true (cons #false (cons #true '() )))) #false)
(check-expect (all-true (cons #true (cons #true (cons #false '() )))) #false)

(define (one-true l)
  (cond
    [(empty? (rest l)) (first l)]
    [(cons? l) (or (first l) (one-true (rest l)))]
    [else #false]))

(check-error (one-true '() ) "rest: expects a non-empty list; given: '()")
(check-expect (one-true (cons #true '()) ) #true)
(check-expect (one-true (cons #false '()) ) #false)
(check-expect (one-true (cons #true (cons #true (cons #true '() )))) #true)
(check-expect (one-true (cons #true (cons #false (cons #true '() )))) #true)
(check-expect (one-true (cons #true (cons #true (cons #false '() )))) #true)
(check-expect (one-true (cons #false (cons #false (cons #true '() )))) #true)
(check-expect (one-true (cons #false (cons #false (cons #false '() )))) #false)
(check-expect (one-true (cons #true (cons #false (cons #false '() )))) #true)
