;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; a Lost-of-amounts is on of:
;; --- '()
;; --- (cons PositiveNumber List-of-a,ounts)
(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+ (first l) (sum (rest l)))]))

(check-expect (sum (cons 1 (cons 1 (cons 1 '() )))) 3)

(check-expect (sum (cons 1 (cons 2 (cons 3 '() )))) 6)

(check-expect (sum (cons 123 (cons 321 (cons 333 '() )))) 777)

(check-expect (sum (cons 3 (cons 4 (cons 9 (cons 3 (cons 2 (cons 1 '() ))))))) 22)

