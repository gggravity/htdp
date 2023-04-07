;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; (define DOT (circle 5 "solid" "red"))
;; (define MT-SCENE (empty-scene 100 100))

;; (define (dots lop)
;;   (local (
;;           ; Posn Image -> Image 
;;           ; adds a DOT at p to scene
;;           (define (add-one-dot p scene)
;;             (place-image DOT (posn-x p) (posn-y p) scene)))

;;     (foldr add-one-dot MT-SCENE lop)))

;; (define l1 (list (make-posn 10 10) (make-posn 20 20) (make-posn 30 30) (make-posn 40 40)))

;; (dots l1)


(define (convert-usd-eur loc)
  (local ((define (usd-eur amount)
            (* amount 1.06))
          )
    (map usd-eur loc)))

(define l1 (build-list 10 add1))

(check-expect (convert-usd-eur l1) '(1.06 2.12 3.18 4.24 5.3 6.36 7.42 8.48 9.54 10.6))

(define (fahrenheit-to-celsius lod)
  (local  (
           ;; Number -> Number
           ;; convert a F degree into a C degree
           (define (f-to-c degree)
             (* (- degree 32) 5/9))
           )
    (map f-to-c lod)))

(define l2 (build-list 5 add1))

(check-expect (fahrenheit-to-celsius l2) '(-155/9 -50/3 -145/9 -140/9 -15))

(define (translate lop)
  (local (
          (define (convert-posn-to-pair p)
            (list (posn-x p) (posn-y p)))
          )
    (map convert-posn-to-pair lop)))

(define l3
  (list
   (make-posn 1 2) (make-posn 3 4) (make-posn 5 6) (make-posn 7 8) (make-posn 9 10)))

(check-expect (translate l3) '((1 2) (3 4) (5 6) (7 8) (9 10)))

