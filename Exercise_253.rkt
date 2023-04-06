;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; [Number -> Boolean]
(odd? 1)
(even? 1)

;; [Boolean String -> Boolean]
(define (tf b s)
  (if b (string-append s "TRUE!!!") (string-append "!!!FALSE" s)))

(tf #true "HELLO")
(tf #false "WORLD")
(tf #false "HELLO")

;; [Number Number Number -> Number]

(min 1 2 3)
(max 1 2 3)

;; [Number -> [List-of Number]]

(define (countdown n)
  (if (= n 0) '()
      (cons n (countdown (- n 1)))))

(countdown 10)
  
;; [[List-of Number] -> Boolean]

(define (<=3 l)
  (if (empty? l) '()
      (if (<= (first l) 3)
          (cons (first l) (<=3 (rest l)))
          (<=3 (rest l))
          )))

(<=3 (countdown 10))
