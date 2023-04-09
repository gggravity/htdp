;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; List-of-numbers -> List-of-numbers
;; converts a list of dollers into a list of euros
;
(define (convert-euro fx-list)
  (map (λ (fx)
         (* 0.9291 fx))
       fx-list))

(check-expect (convert-euro '(10 100 200 333 3000 10000))
              '(9.291 92.91 185.82 309.3903 2787.3 9291))

;; List-of-numbers -> List-of-numbers
;; convert a list of F degrees into a list C degrees
(define (convertFC degrees)
  (map (λ (degree)
         (* (- degree 32) 5/9)
         ) degrees))

(check-expect (convertFC '(100 0 50 150 200))
              '(340/9 -160/9 10 590/9 280/3))


(define (translate lop)
  (map (λ (p) (list (posn-x p) (posn-y p))) lop))

(check-expect (translate (list (make-posn 1 2)
                               (make-posn 3 4)
                               (make-posn 5 6)
                               (make-posn 7 8)
                               (make-posn 9 10)))
              '((1 2)
                (3 4)
                (5 6)
                (7 8)
                (9 10)))

