;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define lon (list "James Brown"
                  "James Bond"
                  "Jill Boolean"
                  "Bob Backward"
                  "Rainbow Rick"
                  ))

(define (find-name name names)
  (local ((define sl-name (string-length name))
          (define (starts-with? n)
            (and (<= sl-name (string-length n))
                 (string=? (substring n 0 sl-name) name))))
    (for/or ([name names])
      (if (starts-with? name) name #false))))

(check-expect (find-name "Jam" lon) "James Brown")
(check-expect (find-name "James Bo" lon) "James Bond")
(check-expect (find-name "James Brownie" lon) #false)
(check-expect (find-name "B" lon) "Bob Backward")
(check-expect (find-name "a-haa-haa-haa-haa-haa-haa-haa-haa-haa-haa-haa-ha" lon) #false)

(define (all-names-shorter-then-n names max-length)
  (for/and ([name names])
    (< max-length (string-length name))))

(check-expect (all-names-shorter-then-n lon 6) #true)
(check-expect (all-names-shorter-then-n lon 20) #false)
