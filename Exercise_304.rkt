;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

; [List-of X] -> [List-of [List N X]]
; pairs each item in lx with its index 

(check-expect (enumerate '(a b c)) '((1 a) (2 b) (3 c)))

(define (enumerate lx)
  (for/list ([x lx] [ith (length lx)])
    (list (+ ith 1) x)))

(define l1 '(a b c))

(define (enum l)
  (for/list ([x l] [y (length l)])
    (list (add1 y) x)))

(check-expect (enum l1) (enumerate l1))

(for/list ([i 2] [j '(a b)])
  (list i j))

(for*/list ([i 2] [j '(a b)])
  (list i j))

(define (test n)
  (for*/list ([x n] [y n])
    (if (eq? x y) 1 0)))

(test 3)

(define (test2 n)
  (for/list ([x n])
    (for/list ([y n])
      (if (eq? x y) 1 0))))

(test2 10)

    
