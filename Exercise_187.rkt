;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define-struct gp [name score])
;; A GamePlayer is a structure:
;;   (make-gp String Number)
;; interpretation (make-gp p s) represents player p who
;; scored a maximum of s points

(define (gp>= gp1 gp2)
 (>= (gp-score gp1) (gp-score gp2)))

;; List-of-gp -> List-of-gp
;; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [else (insert (first l) (sort> (rest l)))]
    ))

(check-expect (sort> '()) '())

(check-expect (sort> (list (make-gp "A" 10) (make-gp "B" 2) (make-gp "C" 21)))
              (list (make-gp "C" 21) (make-gp "A" 10) (make-gp "B" 2)))

(check-expect (sort> (list (make-gp "A" 10)))
              (list (make-gp "A" 10)))

(check-expect (sort> (list (make-gp "Z" 1) (make-gp "Z" 2) (make-gp "Z" 3)))
              (list (make-gp "Z" 3) (make-gp "Z" 2) (make-gp "Z" 1)))

(check-expect (sort> (list (make-gp "Z" 3) (make-gp "Z" 2) (make-gp "Z" 1)))
              (list (make-gp "Z" 3) (make-gp "Z" 2) (make-gp "Z" 1)))

;; gp List-of-gp -> List-of-gp
;; inserts n into the sorted list of gp l
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (gp>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l)))
              )]))

(check-expect (insert (make-gp "B" 2) (list (make-gp "A" 1))) (list (make-gp "B" 2) (make-gp "A" 1)))

(check-expect (insert (make-gp "B" 1) (list (make-gp "A" 2))) (list (make-gp "A" 2) (make-gp "B" 1)))

(check-expect (insert (make-gp "B" 2) (list)) (list (make-gp "B" 2)))

(check-expect (insert (make-gp "B" 2) (list (make-gp "Q" 23) (make-gp "A" 22)))
              (list (make-gp "Q" 23) (make-gp "A" 22) (make-gp "B" 2)))


