;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else
     (cons
      (sin n)
      (tab-sin (sub1 n)))]))
	

; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons
      (sqrt n)
      (tab-sqrt (sub1 n)))]))

(define (tabulate r n)
  (if (= n 0) (list (r 0))
      (cons (r n) (tabulate r (sub1 n)))))

(define (tabulate-sqrt n)
  (tabulate sqrt n))

(tabulate-sqrt 10)

(define (tabulate-sin n)
  (tabulate sin n))

(tabulate-sin 10)

(define (tabulate-sqr n)
  (tabulate sqr n))

(tabulate-sqr 10)

(define (tabulate-tan n)
  (tabulate tan n))

(tabulate-tan 10)
