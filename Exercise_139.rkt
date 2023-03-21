;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; a Lost-of-amounts is on of:
;; --- '()
;; --- (cons Number List-of-amounts)
(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+ (first l) (sum (rest l)))]))

(check-expect (sum (cons 1 (cons 1 (cons 1 '() )))) 3)

(check-expect (sum (cons 1 (cons 2 (cons 3 '() )))) 6)

(check-expect (sum (cons 123 (cons 321 (cons 333 '() )))) 777)

(check-expect (sum (cons 3 (cons 4 (cons 9 (cons 3 (cons 2 (cons 1 '() ))))))) 22)

(define (pos? l)
  (cond
    [(empty? l) #true]
    [(cons? l) (and (>= (first l) 0) (pos? (rest l)))]
    [else #false]))


(check-expect (pos? '() ) #true)

(check-expect (pos? (cons 5 '()) ) #true)

(check-expect (pos? (cons -1 '()) ) #false)

(check-expect (pos? (cons 0 '() )) #true)

(check-expect (pos? (cons 1 (cons 1 (cons 1 '() )))) #true)

(check-expect (pos? (cons 1 (cons 2 (cons 3 '() )))) #true)

(check-expect (pos? (cons -123 (cons 321 (cons 333 '() )))) #false)

(check-expect (pos? (cons 3 (cons 4 (cons 9 (cons 3 (cons 2 (cons 1 '() ))))))) #true)


(define ERROR-MESSAGE "List need all positive numbers")

(define-struct vec [x y])
;; A vec is
;;   (make-vec PositiveNumber PositiveNumber)
;; interpretation represents a velocity vector

(define (checked-sum l)
  (cond
    [(pos? l) (sum l)]
    [else (error ERROR-MESSAGE)]))

(check-expect (checked-sum (cons 1 (cons 1 (cons 1 '() )))) 3)

(check-expect (checked-sum (cons 1 (cons 2 (cons 3 '() )))) 6)

(check-expect (checked-sum (cons 123 (cons 321 (cons 333 '() )))) 777)

(check-expect (checked-sum (cons 3 (cons 4 (cons 9 (cons 3 (cons 2 (cons 1 '() ))))))) 22)

(check-error (checked-sum (cons 1 (cons -1 (cons 1 '() )))) ERROR-MESSAGE)

(check-error (checked-sum (cons 1 (cons 2 (cons -3 '() )))) ERROR-MESSAGE)

(check-error (checked-sum (cons -123 (cons 321 (cons 333 '() )))) ERROR-MESSAGE)

(check-error (checked-sum (cons 3 (cons -4 (cons 9 (cons 3 (cons -2 (cons 1 '() ))))))) ERROR-MESSAGE)

