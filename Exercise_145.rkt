;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; ;; NEList-of-temperatures -> Number
;; ;; computes the average temperature
;; (define (average ne-l)
;;   (/ (sum ne-l)
;;      (how-many ne-l)))

;; ;; NeList-of-temperatures -> Number
;; ;; adds up the temperatures on the given list
;; (define (sum ne-l)
;;   (cond
;;     [(empty? (rest ne-l)) (first ne-l)]
;;     [else (+ (first ne-l) (sum (rest ne-l)))]))

;; ;; List-of-temperatures -> Number
;; (define (how-many alot)
;;   (cond
;;     [(empty? alot) 0]
;;     [else (+ (how-many (rest alot)) 1)]))

;; ;; (check-error (average '())  "/: division by zero")

;; (check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)

;; (check-expect (average (cons 4 (cons 6 (cons 3 (cons 3 (cons 4 '())))))) 4)

(define (sorted>? l)
  (cond
    [(empty? (rest l)) #true]
    [else
     (and
      (> (first l) (first (rest l)))
      (sorted>? (rest l))
      )]))

(check-expect (sorted>? (cons 1 '())) #true)

(check-expect (sorted>? (cons 5 (cons 4 (cons 3 (cons 2 (cons 1 '())))))) #true)

(check-expect (sorted>? (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))) #false)

;; (define l1 (cons 5 (cons 4 (cons 3 (cons 2 (cons 1 '()))))))
;; (define l2 (cons 1 '()))
;; (define le '())

;; (rest l2)
