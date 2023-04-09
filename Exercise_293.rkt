;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define l1 '(2 3 1 9 5 8 4 0 1 4))

; X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

(check-expect (find 9 l1) '(9 5 8 4 0 1 4))
(check-expect (find 1 l1) '(1 9 5 8 4 0 1 4))
(check-expect (find 0 l1) '(0 1 4))
(check-expect (find 06 l1) #false)

(define (found-another-way? x l)
  (local ((define (find-index i x l)
            (if (empty? l) -1
                (if (equal? x (first l)) i
                    (find-index (add1 i) x (rest l)))))
          (define (sublist i l)
            (cond
              [(zero? i) l]
              [(negative? i) #false]
              [else (sublist (sub1 i) (rest l))])))
    (sublist (find-index 0 x l) l)))



(define (found? n l)
  (λ (cmp)
    (equal? (found-another-way? n l) cmp)))

;; (sublist (find-index 0 9 l1) l1)
(check-expect (found-another-way? 9 l1) '(9 5 8 4 0 1 4))
(check-expect (found-another-way? 1 l1) '(1 9 5 8 4 0 1 4))
(check-expect (found-another-way? 0 l1) '(0 1 4))

(check-expect (find 9 l1) (found-another-way? 9 l1))
(check-expect (find 3 l1) (found-another-way? 3 l1))
(check-expect (find 6 l1) (found-another-way? 6 l1))

(check-satisfied (find 9 l1) (found? 9 l1))
(check-satisfied (find 3 l1) (found? 3 l1))
(check-satisfied (find 6 l1) (found? 6 l1))

