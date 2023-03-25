;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;; Image N -> Number
;; computes put image inside beside 
(define (col img n)
  (if (eq? n 1) img
      (beside img (col img (sub1 n)))))

;; Image N -> Number
;; computes put image inside above 
(define (row img n)
  (if (eq? n 1) img
      (above img (row img (sub1 n)))))

(check-expect (col (circle 10 "solid" "gray") 5)
              (beside (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")
                      (circle 10 "solid" "gray")))

(check-expect (row (circle 10 "solid" "gray") 5)
              (above (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")
                     (circle 10 "solid" "gray")))


(define lecture-hall (row (col (square 10 "solid" "navy") 8) 18))

(define background (place-image/align lecture-hall 0 0 "left" "top" (empty-scene 80 180)))

(define c (circle 5 "solid" "red"))

(define (add-balloons l img)
  (if (empty? l) img
      (place-image c (posn-x (first l)) (posn-y (first l))
                   (add-balloons (rest l) img))))

(define (render scene)
  scene)

(define (main scene)
  (big-bang scene
            [to-draw render]))

(define list-of-balloones-1 '())
(define list-of-balloones-2 (cons (make-posn 60 90) (cons (make-posn 30 30) '())))
(define list-of-balloones-3 (cons (make-posn 0 30)
                                  (cons (make-posn 60 150)
                                        (cons (make-posn 30 30)
                                              (cons (make-posn 60 90)
                                                    (cons (make-posn 10 20)
                                                          (cons (make-posn 30 100)
                                                                '())))))))

(main (add-balloons list-of-balloones-3 background))
