;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (tr p)
  (make-posn (posn-x p) (add1 (posn-y p))))

;; List-of-posn -> List-of-posn
;; produce is list of posn with one added to the y value
(define (translate l)
  (cond
    [(empty? l) '()]
    [else (cons (tr (first l)) (translate (rest l)))]))

(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 1 2) (cons (make-posn 1 2) '())))
	      (cons (make-posn 1 3) (cons (make-posn 1 3) '())))
(check-expect (translate (cons (make-posn 2 2) (cons (make-posn 3 2) '())))
	      (cons (make-posn 2 3) (cons (make-posn 3 3) '())))
(check-expect (translate (cons (make-posn 9 18) (cons (make-posn 2 2) (cons (make-posn 3 2) '()))))
	      (cons (make-posn 9 19) (cons (make-posn 2 3) (cons (make-posn 3 3) '()))))

