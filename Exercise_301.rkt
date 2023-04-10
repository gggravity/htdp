;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (insertion-sort alon)
  (local ((define (sort alon)
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort (rest alon)))]))
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon)
                             (add an (rest alon)))])])))
    (sort alon)))

(define (sort2 alon)
  (local ((define (sort alon)
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort (rest alon)))]))
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon)
                             (add an (rest alon)))])])))
    (sort alon)))


(sort2 '(8 5 3 6 4 5 8))
(insertion-sort '(8 5 3 6 4 5 8))

; same functions different names
