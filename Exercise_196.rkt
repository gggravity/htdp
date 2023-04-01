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

(check-expect (starts-with# (list) "a") 0)
(check-expect (starts-with# (list "aaa" "bbb" "abc") "a") 2)
(check-expect (starts-with# (list "aaa" "bbb" "abc") "b") 1)
(check-expect (starts-with# (list "aaa" "bbb" "abc") "x") 0)
(check-expect (starts-with# AS-LIST "e") 3307)
(check-expect (starts-with# AS-LIST "z") 151)

(define-struct letter-counts [letter count])

(define (count-by-letter dict letters)
  (if (empty? letters)
      (list)
      (cons
       (make-letter-counts
        (first letters)
        (starts-with# dict (first letters)))
       (count-by-letter dict (rest letters)))
      ))

(check-expect (count-by-letter AS-LIST LETTERS)
              (list (make-letter-counts "a" 4705)
                    (make-letter-counts "b" 4913)
                    (make-letter-counts "c" 8260)
                    (make-letter-counts "d" 5176)
                    (make-letter-counts "e" 3307)
                    (make-letter-counts "f" 3745)
                    (make-letter-counts "g" 2799)
                    (make-letter-counts "h" 3122)
                    (make-letter-counts "i" 3385)
                    (make-letter-counts "j" 777)
                    (make-letter-counts "k" 621)
                    (make-letter-counts "l" 2644)
                    (make-letter-counts "m" 4496)
                    (make-letter-counts "n" 1560)
                    (make-letter-counts "o" 1967)
                    (make-letter-counts "p" 6822)
                    (make-letter-counts "q" 417)
                    (make-letter-counts "r" 4721)
                    (make-letter-counts "s" 10070)
                    (make-letter-counts "t" 4354)
                    (make-letter-counts "u" 1826)
                    (make-letter-counts "v" 1280)
                    (make-letter-counts "w" 2362)
                    (make-letter-counts "x" 57)
                    (make-letter-counts "y" 285)
                    (make-letter-counts "z" 151)))

;; (count-by-letter AS-LIST LETTERS)
