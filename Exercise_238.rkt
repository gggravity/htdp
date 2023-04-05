;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; Nelon -> Number
; determines the smallest 
; number on l
(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (< (first l)
            (inf (rest l)))
         (first l)
         (inf (rest l)))]))

; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (> (first l)
            (sup (rest l)))
         (first l)
         (sup (rest l)))]))

(define list1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))

(define list2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))

(define (comp p l)
  (if (empty? (rest l)) (first l)
      (if (p (first l) (comp p (rest l))) (first l)
          (comp p (rest l)))))

(define (comp< l)
  (comp < l))

(define (comp> l)
  (comp > l))

(check-expect (inf list1) (comp< list1))
(check-expect (inf list2) (comp< list2))

(check-expect (sup list1) (comp> list1))
(check-expect (sup list2) (comp> list2))

; Nelon -> Number
; determines the smallest 
; number on l
(define (inf2 l)
  (if (empty? (rest l)) (first l)
      (min (first l) (inf2 (rest l)))))

; Nelon -> Number
; determines the largest 
; number on l
(define (sup2 l)
  (if (empty? (rest l)) (first l)
      (max (first l) (sup2 (rest l)))))

(check-expect (inf2 list1) (inf list1))
(check-expect (inf2 list2) (inf list2))

(check-expect (sup2 list1) (sup list1))
(check-expect (sup2 list2) (sup list2))

(define (comp2 r l)
  (if (empty? (rest l)) (first l)
      (r (first l) (comp2 r (rest l)))))

(define (comp2< l)
  (comp2 min l))

(define (comp2> l)
  (comp2 max l))

(check-expect (inf2 list1) (comp2< list1))
(check-expect (inf2 list2) (comp2< list2))

(check-expect (sup2 list1) (comp2> list1))
(check-expect (sup2 list2) (comp2> list2))


