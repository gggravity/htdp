;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

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

(define (prefixes2 l)
  (local (
          (define (make-incremental-list f r)
            (local (
                    (define (append-to-back item)
                      (append (list f) item))
                    )
              (map append-to-back (cons '() r))
              ))
          (define (helper l)
            (foldr make-incremental-list '() l))
          )
    (reverse (helper l))
    ))

(check-expect (prefixes2 (list)) (list))
(check-expect (prefixes2 (list "a")) (list (list "a")))
(check-expect (prefixes2 (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d")
                    (list "a" "b" "c")
                    (list "a" "b")
                    (list "a")
                    ))

(define (suffixes2 l)
  (local (
          (define (make-incremental-list f r)
            (local (
                    (define (appand-to-front item)
                      (append item (list f)))
                    )
              (map appand-to-front (cons '() r))
              ))
          (define (helper l)
            (foldl make-incremental-list '() l))
          )
    (reverse (helper l))
    ))

(check-expect (suffixes2 (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d")
                    (list "b" "c" "d")
                    (list "c" "d")
                    (list "d")
                    ))
