;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (build-natural-numbers-0-to-n n)
  (build-list (add1 n) (λ (x) (+ x))))

(check-expect (build-natural-numbers-0-to-n 10)
              '(0 1 2 3 4 5 6 7 8 9 10))

(define (build-natural-numbers-1-to-n n)
  (build-list n (λ (x) (add1 x))))

(check-expect (build-natural-numbers-1-to-n 10)
              '(1 2 3 4 5 6 7 8 9 10))

(define (build-natural-numbers-1-to-1/n n)
  (map (λ (n) (/ 1 n))
       (build-list n (λ (x) (add1 x)))))

(check-expect (build-natural-numbers-1-to-1/n 10)
              '(1 0.5 1/3 0.25 0.2 1/6 1/7 0.125 1/9 0.1))

(define (first-n-even-numbers n)
  (filter even? (build-list n (λ (x) (* (add1 x) 2)))))

(check-expect (first-n-even-numbers 10)
              '(2 4 6 8 10 12 14 16 18 20))

(define (identity-matrix n)
  (build-list n (λ (i)
                  (build-list n (λ (j)
                                  (if (= i j) 1 0))))))

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

(define (tab1 r n)
  (if (= n 0) (list (r 0))
      (cons (r n) (tab1 r (sub1 n)))))

(define (tab2 fn n)
  (map fn (reverse (build-list (add1 n) +))))

(define (tab3 fn n)
  (map fn (reverse (build-list (add1 n) (λ (x) (+ x))))))

(check-expect(tab1 sqr 5) '(25 16 9 4 1 0))
(check-expect(tab2 sqr 5) '(25 16 9 4 1 0))
(check-expect(tab3 sqr 5) '(25 16 9 4 1 0))

