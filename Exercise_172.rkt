;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(define line1 (cons "hello" (cons "world" '())))
(define line2 (cons "pale" (cons "blue" (cons "dot" '()))))

(define lol1 (cons line1 (cons line2 '())))
(define lol2 (cons line2 (cons line1 '())))

(define (collapse-line line)
  (cond
    [(empty? line) ""]
    [(empty? (rest line)) (first line)]
    [else (string-append (first line) " " (collapse-line (rest line)))]))

(check-expect (collapse-line '()) "")
(check-expect (collapse-line line1) "hello world")
(check-expect (collapse-line line2) "pale blue dot")

(define (collapse-lol lol)
  (cond
    [(empty? lol) ""]
    [else (string-append (collapse-line (first lol)) "\n" (collapse-lol (rest lol)))]))

(check-expect (collapse-lol '()) "")
(check-expect (collapse-lol lol1) "hello world\npale blue dot\n")
(check-expect (collapse-lol lol2) "pale blue dot\nhello world\n")

(write-file "ttt.dat" (collapse-lol (read-words/line "ttt.txt")))

