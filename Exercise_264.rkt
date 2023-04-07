;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; Nelon -> Number
; determines the largest 
; number on l
(define (sup-old l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (> (first l)
            (sup-old (rest l)))
         (first l)
         (sup-old (rest l)))]))

(define (sup l)
  (if (empty? (rest l))
      (first l)
      (local ((define sup-rest (sup (rest l))))
        (if (> (first l) sup-rest)  (first l)
            sup-rest))))

(sup (list 2 1 3))
(sup-old (list 2 1 3))
