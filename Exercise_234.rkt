;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))

(check-expect (add-ranks one-list) '((3 "Asia: Heat of the Moment")
                                     (2 "U2: One")
                                     (1 "The White Stripes: Seven Nation Army")))

(define (ranking los)
  (reverse (add-ranks (reverse los))))

(check-expect (ranking one-list) '((1 "Asia: Heat of the Moment")
                                   (2 "U2: One")
                                   (3 "The White Stripes: Seven Nation Army")))

(define (make-cell n)
  (if (number? n)
      `(td ,(number->string n))
      `(td ,n)
      ))

(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]))

(define (make-table-rows l)
  (if (empty? l) '()
      (cons `(tr ,@(make-row (first l))) (make-table-rows (rest l)))))

(define make-table
  `(table ((border "1"))
          ,@(make-table-rows (ranking one-list))
          ))

(check-expect
 `(html
   (body
    ,make-table
    )
   )

 '(html
   (body
    (table ((border "1"))
           (tr (td "1") (td "Asia: Heat of the Moment"))
           (tr (td "2") (td "U2: One"))
           (tr (td "3") (td "The White Stripes: Seven Nation Army"))))))
