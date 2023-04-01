;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/batch-io)

(define LOCATION "/usr/share/dict/words")

(define AS-LIST (read-lines LOCATION))

;; A Letter is one of the followinf 1String
;; -- "a"
;; -- ...
;; -- "z"
;; or, equivalently, a member? of the list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define (first-char s)
  (substring s 0 1))

(check-expect (first-char "abc") "a")
(check-expect (first-char "cba") "c")
(check-expect (first-char "1bc") "1")


(define (starts-with# l str)
  (if (empty? l)
      0
      (if (string=? (first-char (first l)) str)
          (add1 (starts-with# (rest l) str))
          (starts-with# (rest l) str)
          )
      ))

(check-expect (starts-with# (list "aaa" "bbb" "abc") "a") 2)
(check-expect (starts-with# (list "aaa" "bbb" "abc") "b") 1)
(check-expect (starts-with# (list "aaa" "bbb" "abc") "x") 0)
(check-expect (starts-with# AS-LIST "e") 3307)
(check-expect (starts-with# AS-LIST "z") 151)


