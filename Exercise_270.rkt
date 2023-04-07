;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (build-natural-numbers-0-to-n n)
  (build-list (add1 n) +))

(check-expect (build-natural-numbers-0-to-n 10)
              '(0 1 2 3 4 5 6 7 8 9 10))

(define (build-natural-numbers-1-to-n n)
  (build-list n add1))

(check-expect (build-natural-numbers-1-to-n 10)
              '(1 2 3 4 5 6 7 8 9 10))

(define (build-natural-numbers-1-to-1/n n)
  (local ((define (inverse n)
            (/ 1 n)))
    (map inverse (build-natural-numbers-1-to-n n))))

(check-expect (build-natural-numbers-1-to-1/n 10)
              '(1 0.5 1/3 0.25 0.2 1/6 1/7 0.125 1/9 0.1))

(define (first-n-even-numbers n)
  (filter even? (build-natural-numbers-1-to-n (* 2 n))))

(check-expect (first-n-even-numbers 10)
              '(2 4 6 8 10 12 14 16 18 20))

(define (identity-matrix n)
  (local (
          (define (build-row i)
            (local ((define (one-at-offset j)
                      (if (= i j) 1 0)))
              (build-list n one-at-offset)))
          )
    (build-list n build-row)))

(check-expect (identity-matrix 0) '())

(check-expect (identity-matrix 1) '((1)))

(check-expect (identity-matrix 3) '((1 0 0)
                                    (0 1 0)
                                    (0 0 1)))

(check-expect (identity-matrix 10) '((1 0 0 0 0 0 0 0 0 0)
                                     (0 1 0 0 0 0 0 0 0 0)
                                     (0 0 1 0 0 0 0 0 0 0)
                                     (0 0 0 1 0 0 0 0 0 0)
                                     (0 0 0 0 1 0 0 0 0 0)
                                     (0 0 0 0 0 1 0 0 0 0)
                                     (0 0 0 0 0 0 1 0 0 0)
                                     (0 0 0 0 0 0 0 1 0 0)
                                     (0 0 0 0 0 0 0 0 1 0)
                                     (0 0 0 0 0 0 0 0 0 1)))

(define (tabulate r n)
  (if (= n 0) (list (r 0))
      (cons (r n) (tabulate r (sub1 n)))))

(tabulate sqr 5)

(define (tab2 fn n)
  (map fn (reverse (build-list (add1 n) +))))

(tab2 sqr 5)
