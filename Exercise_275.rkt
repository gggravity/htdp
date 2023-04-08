;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

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

(define (starts-with# dict letter)
  (local ((define (check current letter)
            (string=? (first-char current) letter))
          (define (count word counter)
            (if (check word letter) (add1 counter) counter)))
    (foldl count 0 dict)))

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

;; List-of-letter-counts -> List-of-letter-counts
;; produces a list sorted letter-counts by count
(define (sort-lc> l)
  (sort l lc>=))

(check-expect (sort-lc> '()) '())
(check-expect (sort-lc> (list (make-letter-counts "a" 3) (make-letter-counts "b" 2)))
              (list (make-letter-counts "a" 3) (make-letter-counts "b" 2)))
(check-expect (sort-lc> (list (make-letter-counts "a" 1) (make-letter-counts "b" 2)))
              (list (make-letter-counts "b" 2) (make-letter-counts "a" 1)))

(define (count-by-letter dict letters)
  (local ((define (count letter)
            (make-letter-counts letter (starts-with# dict letter))))
    (map count letters)))

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

(define (most-frequent dict)
  (sort-lc> (count-by-letter dict LETTERS)))

(check-expect (most-frequent AS-LIST) (list (make-letter-counts "s" 10070)
                                            (make-letter-counts "c" 8260)
                                            (make-letter-counts "p" 6822)
                                            (make-letter-counts "d" 5176)
                                            (make-letter-counts "b" 4913)
                                            (make-letter-counts "r" 4721)
                                            (make-letter-counts "a" 4705)
                                            (make-letter-counts "m" 4496)
                                            (make-letter-counts "t" 4354)
                                            (make-letter-counts "f" 3745)
                                            (make-letter-counts "i" 3385)
                                            (make-letter-counts "e" 3307)
                                            (make-letter-counts "h" 3122)
                                            (make-letter-counts "g" 2799)
                                            (make-letter-counts "l" 2644)
                                            (make-letter-counts "w" 2362)
                                            (make-letter-counts "o" 1967)
                                            (make-letter-counts "u" 1826)
                                            (make-letter-counts "n" 1560)
                                            (make-letter-counts "v" 1280)
                                            (make-letter-counts "j" 777)
                                            (make-letter-counts "k" 621)
                                            (make-letter-counts "q" 417)
                                            (make-letter-counts "y" 285)
                                            (make-letter-counts "z" 151)
                                            (make-letter-counts "x" 57)))

(define (filter-dict l letter)
  (local ((define (first-char s)
            (substring s 0 1))
          (define (starts-with? word)
            (string=? letter (first-char word))))
    (filter starts-with? l)))

(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "a") (list "aa" "ab"))
(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "b") (list "bb" "bc"))
(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "d") (list "dd"))
(check-expect (filter-dict (list) "c") (list))
(check-expect (filter-dict (list "aa" "ab" "bb" "bc" "dd") "c") (list))

(define (word-list dict lol)
  (local ((define (check l)
            (filter-dict dict l)))
    (map check lol)))

(check-expect (word-list (list "aa" "ab" "bb" "bc" "dd") (list "a" "b" "c" "d"))
              (list
               (list "aa" "ab")
               (list "bb" "bc")
               (list)
               (list "dd")))

(define (words-by-first-letter dict)
  (local ((define (is-empty? l fn)
            (if (empty? l) (list) fn)))
    (is-empty? dict (word-list dict LETTERS))))

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
