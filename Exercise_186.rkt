;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; from Exercise 145
(define (sorted? l)
  (cond
    [(empty? (rest l)) #true]
    [else
     (and
      (> (first l) (first (rest l)))
      (sorted? (rest l))
      )]))

;; List-of-numbers -> List-of-numbers
;; produces a sorted version of alon
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else (insert (first alon) (sort> (rest alon)))]
    ))

(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5)) (list 20 12 -5))

(check-satisfied (sort> (list 3 2 1)) sorted?)
(check-satisfied (sort> (list 1 2 3)) sorted?)
(check-satisfied (sort> (list 12 20 -5)) sorted?)

;; Number List-of-number -> List-of-numbers
;; inserts n into the sorted list of numbers alon
(define (insert n alon)
  (cond
    [(empty? alon) (cons n '())]
    [else (if (>= n (first alon))
              (cons n alon)
              (cons (first alon) (insert n (rest alon)))
              )]))

(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5)) (list 20 12 -5))

;; List-of-numbers -> List-of-numbers
;; produces a sorted version of l
(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0)) ; l is not used.

(check-satisfied (sort>/bad (list 1 2 3)) sorted?) ; always true

