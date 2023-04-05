;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; String Los -> Boolean
;; determines whether l contains the string s
(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))

(define (contains-atom? l)
  (contains? "atom" l))

(check-expect (contains-atom? '("adam" "atom" "eva")) #true)
(check-expect (contains-atom? '("adam" "eva")) #false)

(define (contains-basic? l)
  (contains? "basic" l))

(check-expect (contains-basic? '("adam" "basic" "eva")) #true)
(check-expect (contains-basic? '("adam" "eva")) #false)

(define (contains-zoo? l)
  (contains? "zoo" l))

(check-expect (contains-zoo? '("adam" "eva" "zoo")) #true)
(check-expect (contains-zoo? '("adam" "eva" "zoom")) #false)
