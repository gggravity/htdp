;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


(define l1 (list 1 2 3))
(define l2 (list 4 5 6 7 8))
(define l3 (list 1 2 3 4 5 6 7 8))

;; (equal? (append l1 l2) l3)

(define (append-from-fold l1 l2)
  (foldr cons l2 l1))

(check-expect (append-from-fold l1 l2) l3)


;; the first list (l1) is reversed

(define (sum-of-list l)
  (foldl + 0 l))

(check-expect (sum-of-list l3) (+ 1 2 3 4 5 6 7 8))

(define (procuct-of-list l)
  (foldl * 1 l))

(check-expect(procuct-of-list l3) (* 1 2 3 4 5 6 7 8))

(define ellipses-beside (list (ellipse 20 70 "solid" "gray")
                              (ellipse 20 50 "solid" "darkgray")
                              (ellipse 20 30 "solid" "dimgray")
                              (ellipse 20 10 "solid" "black")))

(define ellipses-above (list (ellipse 70 20 "solid" "gray")
                             (ellipse 50 20 "solid" "darkgray")
                             (ellipse 30 20 "solid" "dimgray")
                             (ellipse 10 20 "solid" "black")
                             ))

(define (beside-align-top i1 i2)
  (beside/align "top" i1 i2))

(foldr beside-align-top empty-image ellipses-beside)

(check-expect (foldr beside-align-top empty-image ellipses-beside)
              (beside/align
               "top" (ellipse 20 70 "solid" "gray")
               (beside/align
                "top" (ellipse 20 50 "solid" "darkgray")
                (beside/align
                 "top" (ellipse 20 30 "solid" "dimgray")
                 (beside/align
                  "top" (ellipse 20 10 "solid" "black")
                  empty-image)))))

(check-expect (foldr above empty-image ellipses-above)
              (above
               (ellipse 70 20 "solid" "gray")
               (above
                (ellipse 50 20 "solid" "darkgray")
                (above
                 (ellipse 30 20 "solid" "dimgray")
                 (above
                  (ellipse 10 20 "solid" "black")
                  empty-image)))))
