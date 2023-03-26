;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(define (print-list lol)
  (cond
    [(empty? lol) ""]
    [else (cons (first lol) (print-list (rest lol)))]))

(define (sum l)
  (cond
    [(empty? l) 0]
    [else (add1 (sum (rest l)))]))


(define (wc filename)
  (sum (explode (read-file filename))))
              
  
(wc "ttt-org.txt")
(wc "encoded-ttt-org.txt")


