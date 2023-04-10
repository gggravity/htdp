;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)

; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(define (random-posns n)
  (build-list
   n
   (lambda (i)
     (make-posn (random WIDTH) (random HEIGHT)))))

(define (within? p)
  (not (or (or (< (posn-x p) 0)
               (> (posn-x p) WIDTH))
           (or (< (posn-y p) 0)
               (> (posn-y p) HEIGHT))))
  )

(define (n-inside-playground? n)
  (λ (result) 
    (andmap (λ (p) (within? p)) result)))

(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))

(define (random-posns/bad n)
  (build-list n (λ (i) (make-posn (+ (random WIDTH) WIDTH)
                                  (+ (random HEIGHT) HEIGHT)))))

(check-satisfied (random-posns/bad 10)
                 (n-inside-playground? 10))
