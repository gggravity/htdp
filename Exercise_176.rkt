;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; A Matrix is one of:
;; -- (cons Row '())
;; -- (cons Row Matrix)
;; constraint all rows in matrix are of the same length

;; A Row is one of:
;; -- '()
;; -- (cons Number Row)

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

;; Matrix -> list-of-numbers
;; consumes a matrix and producs the first column as a list of numbers
(define (first* m)
    (cond
    [(empty? m) '()]
    [else (cons (first (first m)) (first* (rest m)))]))

(check-expect (first* mat1) (cons 11 (cons 21 '())))

;; Matrix -> Matrix
;; consumes a matrix and removes the first column.
(define (rest* m)
    (cond
    [(empty? m) '()]
    [else (cons (rest (first m)) (rest* (rest m)))]))

(check-expect (rest* mat1) (cons 12 (cons 22 '()))) ; wish function

;; Matrix -> Matrix
;; transpose the given matrix along the diagonal
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]
  ))

(check-expect (transpose mat1) tam1)

