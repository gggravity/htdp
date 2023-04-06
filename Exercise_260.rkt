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

(define (inf-local l)
  (if (empty? (rest l)) (first l)
      (local ((define inf-rest (inf (rest l))))
        (if (< (first l) inf-rest)
            (first l)
            inf-rest))))

(define list1 (reverse (build-list 25 add1)))

(define inf-time (current-seconds))
(inf list1)
(string-append "int: "(number->string (- (current-seconds) inf-time)))

(define inf-local-time (current-seconds))
(inf-local list1)
(string-append "int-local: "(number->string (- (current-seconds) inf-local-time)))
