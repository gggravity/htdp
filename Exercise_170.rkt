;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct phone [area switch four])
;; A Phone is a structure:
;;  (make-phone Three Three Four)
;; A Three is a Number between 100 and 999.
;; A Four is a Number between 1000 and 9999.

(define (test p)
  (if (eq? (phone-area p) 713) #true #false))

(define (change p)
  (make-phone 281 (phone-switch p) (phone-four p)))

;; List-of-phones -> List-of-phones
;; produce is lisst-of-phones with area code 713 replaced with 281
(define (replace l)
  (cond
    [(empty? l) '()]
    [else
       (if (test (first l))
           (cons (change (first l)) (replace (rest l)))
           (cons (first l) (replace (rest l)))
           )]))

(check-expect (replace '()) '())

(check-expect (replace (cons (make-phone 123 123 1234) (cons (make-phone 123 123 1234) '())))
	      (cons (make-phone 123 123 1234) (cons (make-phone 123 123 1234) '())))

(check-expect (replace (cons (make-phone 713 123 1234) (cons (make-phone 123 123 1234) '())))
	      (cons (make-phone 281 123 1234) (cons (make-phone 123 123 1234) '())))

(check-expect (replace (cons (make-phone 713 123 1234) (cons (make-phone 713 123 1234) '())))
	      (cons (make-phone 281 123 1234) (cons (make-phone 281 123 1234) '())))

(check-expect (replace (cons (make-phone 333 123 1234) (cons (make-phone 713 123 1234) '())))
	      (cons (make-phone 333 123 1234) (cons (make-phone 281 123 1234) '())))
