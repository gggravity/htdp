;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;; (define (cat l)
;;   (cond
;;     [(empty? l) ""]
;;     [else (string-append (first l) (cat (rest l)))]))

(define 1x2 (empty-scene 1 2))

(define 1x1 (empty-scene 1 1))

(define (check-image img n)
  (not (= (image-height img) (image-width img) n)))

;; ImageOrFalse is one of:
;; --- Image
;; --- #false
(define (ill-sized? loi n)
  (if
   (empty? loi)
   #false
   (if
    (check-image (first loi) n)
    (first loi)
    (ill-sized? (rest loi) n)
    )))

(check-expect (ill-sized? '() 1) #false)

(check-expect (ill-sized? (cons 1x1 '()) 1 ) #false)

(check-expect (ill-sized? (cons 1x2 '()) 1 ) 1x2)

(check-expect (ill-sized? (cons 1x1 (cons 1x1 (cons 1x1 '() ))) 1) #false)

(check-expect (ill-sized? (cons 1x1 (cons 1x2 (cons 1x1 '() ))) 1) 1x2)

(check-expect (ill-sized? (cons 1x1 (cons 1x1 (cons 1x2 '() ))) 1) 1x2)

(check-expect (ill-sized? (cons 1x1 (cons 1x1 (cons 1x2 '() ))) 2) 1x1)
