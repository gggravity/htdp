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

(define (lc>= lc1 lc2)
  (>= (letter-counts-count lc1) (letter-counts-count lc2)))

(check-expect (lc>= (make-letter-counts "a" 4705) (make-letter-counts "b" 4913)) #false)
(check-expect (lc>= (make-letter-counts "b" 4913) (make-letter-counts "a" 4705)) #true)

;; letter-counts List-of-letter-counts -> List-of-letter-counts
;; inserts n into the sorted list of letter-counts l
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (lc>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l)))
              )]))

(check-expect (insert (make-letter-counts "a" 3) (list (make-letter-counts "b" 2)))
              (list (make-letter-counts "a" 3) (make-letter-counts "b" 2)))


;; List-of-letter-counts -> List-of-letter-counts
;; produces a list sorted letter-counts by count
(define (sort-lc> l)
  (cond
    [(empty? l) '()]
    [else (insert (first l) (sort-lc> (rest l)))]
    ))

(check-expect (sort-lc> '()) '())
(check-expect (sort-lc> (list (make-letter-counts "a" 3) (make-letter-counts "b" 2)))
              (list (make-letter-counts "a" 3) (make-letter-counts "b" 2)))
(check-expect (sort-lc> (list (make-letter-counts "a" 1) (make-letter-counts "b" 2)))
              (list (make-letter-counts "b" 2) (make-letter-counts "a" 1)))

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

(define (most-frequent dict)
  (sort-lc> (count-by-letter dict LETTERS)))


;; (most-frequent AS-LIST)

(define (filter-dict l str)
  (if (empty? l)
      (list)
      (if (string=? (first-char (first l)) str)
          (cons (first l) (filter-dict (rest l) str))
          (filter-dict (rest l) str)
          )
      ))

(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "a") (list "aa" "ab"))
(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "b") (list "bb" "bc"))
(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "d") (list "dd"))
(check-expect (filter-dict (list) "c") (list))
(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "c") (list))


(define (word-list dict lol)
  (if (empty? lol)
      (list)
      (cons (filter-dict dict (first lol)) (word-list dict (rest lol)))
      ))

(check-expect (word-list (list "aa" "ab" "bb" "bc" "dd") (list "a" "b" "c" "d"))
              (list
               (list "aa" "ab")
               (list "bb" "bc")
               (list)
               (list "dd")))

(define (words-by-first-letter dict)
  (if (empty? dict)
      (list)
      (word-list dict LETTERS)
      ))

(check-expect (words-by-first-letter (list)) (list))

(check-expect (words-by-first-letter (list "aa" "ab" "bb" "bc" "dd"))
              (list
               (list "aa" "ab")
               (list "bb" "bc")
               (list)
               (list "dd")
               (list) (list) (list) (list) (list) (list) (list) (list) (list)
               (list) (list) (list) (list) (list) (list) (list) (list) (list)
               (list) (list) (list) (list) ; empty lists for the missing lettes ex. "x" "Z"
               ))


