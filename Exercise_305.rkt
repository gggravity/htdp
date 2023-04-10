;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

; [List-of X] -> [List-of [List-of X]]
; creates a list of all rearrangements of the items in w
(define (arrangements w)
  (cond
    [(empty? w) '(())]
    [else (for*/list ([item w] [arrangement-without-item (arrangements (remove item w))])
            (cons item arrangement-without-item))]))

; [List-of X] -> Boolean 
(define (all-words-from-rat? w)
  (and (member? (explode "rat") w)
       (member? (explode "art") w)
       (member? (explode "tar") w)))

(check-satisfied (arrangements '("r" "a" "t")) all-words-from-rat?)

(for/and ([i 10])
  (= i i))

(for/and ([i 8]) (if (>= i 0) "blank" #false))

(check-expect (for/sum ([c "abc"]) (string->int c))
              (+ (string->int "a")
                 (string->int "b")
                 (string->int "c")))

(check-expect (for/product ([c "abc"]) (+ (string->int c) 1))
              (* (+ (string->int "a") 1)
                 (+ (string->int "b") 1)
                 (+ (string->int "c") 1)))

(define a (string->int "a"))
(for/string ([j 10]) (int->string (+ a j)))


(define (enumerate.v2 lx)
  (for/list ([item lx] [ith (in-naturals 1)])
    (list ith item)))

(enumerate.v2 '(x y z))

; N -> Number 
; adds the even numbers between 0 and n (exclusive)
(check-expect (sum-evens 2) 0)
(check-expect (sum-evens 4) 2)
(define (sum-evens n)
  (for/sum ([i (in-range 0 n 2)]) i)) ;; in-range start end step

(define (convert-usd-eur loc)
  (for/list ([usd loc])
    (* 1.06 usd)))

(define l1 (build-list 10 add1))

(check-expect (convert-usd-eur l1) '(1.06 2.12 3.18 4.24 5.3 6.36 7.42 8.48 9.54 10.6))


