;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (identity-matrix n)
  (local (
          (define (make-row i n)
            (if (=  n 0) '()
                (if (= n i)
                    (cons 1 (make-row i (sub1 n)))
                    (cons 0 (make-row i (sub1 n)))
                    )))
          (define (make-table i n)
            (if (= i 0) '()
                (cons (make-row i n) (make-table (sub1 i) n))
                ))
          )
    (make-table n n)
    )
  )

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
