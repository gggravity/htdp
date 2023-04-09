;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define lon (list "James Brown"
                  "James Bond"
                  "Jill Boolean"
                  "Bob Backward"
                  "Rainbow Rick"
                  ))


(define (find-name name names)
  (ormap (λ (n)
           (and (<= (string-length name) (string-length n))
                (string=? (substring n 0 (string-length name)) name)))
         names))

(check-expect (find-name "Jam" lon) #true)
(check-expect (find-name "James Brown" lon) #true)
(check-expect (find-name "James Brownie" lon) #false)
(check-expect (find-name "a-haa-haa-haa-haa-haa-haa-haa-haa-haa-haa-haa-ha" lon) #false)

;; andmap

(define (all-names-shorter-then-n names max-length)
  (andmap (λ (name)
            (not (<= (string-length name) max-length)))
          names)
  )

(check-expect (all-names-shorter-then-n lon 6) #true)
(check-expect (all-names-shorter-then-n lon 20) #false)


