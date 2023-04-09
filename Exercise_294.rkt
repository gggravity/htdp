;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define l1 '(2 3 1 9 5 8 4 0 1 4))

; X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

(check-expect (index 2 l1) 0)
(check-expect (index 9 l1) 3)
(check-expect (index 1 l1) 2)
(check-expect (index 6 l1) #false)

(define (find-index i x l)
  (if (empty? l) #false
      (if (equal? x (first l)) i
          (find-index (add1 i) x (rest l)))))

(check-expect (find-index 0 2 l1) 0)
(check-expect (find-index 0 9 l1) 3)
(check-expect (find-index 0 1 l1) 2)
(check-expect (find-index 0 6 l1) #false)

(define (is-index? n l)
  (λ (output)
    (equal? (find-index 0 n l) output)))

(check-satisfied (index 2 l1) (is-index? 2 l1))
(check-satisfied (index 9 l1) (is-index? 9 l1))
(check-satisfied (index 1 l1) (is-index? 1 l1))
(check-satisfied (index 6 l1) (is-index? 6 l1))


