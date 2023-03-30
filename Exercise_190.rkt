;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (remove-first l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (second l) (remove-first (rest l)))]
    ))

(check-expect (remove-first (list "a")) (list))
(check-expect (remove-first (list "a" "b" "c" "d")) (list "b" "c" "d")) 

(define (remove-last l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (first l) (remove-last (rest l)))]
    ))

(check-expect (remove-last (list "a")) (list))
(check-expect (remove-last (list "a" "b" "c" "d")) (list "a" "b" "c")) 

(define (prefixes l)
  (cond
    [(empty? l) '()]
    [else (cons l (prefixes (remove-last l)))]))

(check-expect (prefixes (list)) (list))
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b" "c" "d")) 
              (list (list "a" "b" "c" "d")
                    (list "a" "b" "c")
                    (list "a" "b")
                    (list "a")
                    ))

(define (suffixes l)
  (cond
    [(empty? l) '()]
    [else (cons l (suffixes (remove-first l)))]))

(check-expect (suffixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d")
                    (list "b" "c" "d")
                    (list "c" "d")
                    (list "d")
                    ))

