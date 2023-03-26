;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (test p)
  (if (and
       (and (positive? (posn-x p)) (<= (posn-x p) 100))
       (and (positive? (posn-y p)) (<= (posn-y p) 200))
       ) #true #false))
  
;; List-of-posn -> List-of-posn
;; produce is list of posn with with only positions with
;; x values between 0 and 100 and y values between 0 an 200
(define (legal l)
  (cond
    [(empty? l) '()]
    [else
       (if (test (first l))
           (cons (first l) (legal (rest l)))
           (legal (rest l)))
           ]))

(check-expect (legal '()) '())

(check-expect (legal (cons (make-posn 1 2) (cons (make-posn 1 2) '())))
	      (cons (make-posn 1 2) (cons (make-posn 1 2) '())))

(check-expect (legal (cons (make-posn 123 2) (cons (make-posn 1 2) '())))
	      (cons (make-posn 1 2) '()))

(check-expect (legal (cons (make-posn 9 200) (cons (make-posn 2 222) (cons (make-posn 3 2) '()))))
	      (cons (make-posn 9 200) (cons (make-posn 3 2) '())))

