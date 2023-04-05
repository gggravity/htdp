;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; (define (make-row x)
;;   x)

;; `(tr ,(make-row '(3 4 5)))

;; (cons 'tr (make-row '(3 4 5)))

;; `(tr ,@(make-row '(3 4 5)))

;; List-of-numbers -> ... nested list ...
;; creates a row for an HTML table from l
(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]))

(check-expect (make-row '(1 2 3)) '((td "1") (td "2") (td "3")))

;; Number -> ... nested list ...
;; creates a cell for an HTML table from a number 
(define (make-cell n)
  `(td ,(number->string n)))

(check-expect (make-cell 1) '(td "1"))

;; exercise 233

(check-expect `(0 ,@'(1 2 3)) '(0 1 2 3))

(check-expect
 `(("alan" ,(* 2 500))
   ("barb" 2000)
   (,@'("carl" ", the great") 1500)
   ("dawn" 2300))

 '(("alan" 1000)
   ("barb" 2000)
   ("carl" ", the great" 1500)
   ("dawn" 2300)))

(check-expect
 `(html
   (body
    (table ((border "1"))
           (tr ((width "200"))
               ,@(make-row '(1 2)))
           (tr ((width "200"))
               ,@(make-row '(99 65))))))
 '(html
   (body
    (table ((border "1"))
           (tr ((width "200")) (td "1") (td "2"))
           (tr ((width "200")) (td "99") (td "65")))))
 )
