;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

;; [Number] [Number] [function] -> [List-of X]
(define (build-interval i1 i2 fn)
  (if (>= i1 i2) '()
      (cons (fn i1) (build-interval (add1 i1) i2 fn))))

;; [Number] [function] -> [List-of X]
(define (build-l*ist n fn)
  (build-interval 0 n fn))

(check-expect (build-list 10 add1) (build-l*ist 10 add1))
(check-expect (build-list 10 sub1) (build-l*ist 10 sub1))
(check-expect (build-list 10 number->string) (build-l*ist 10 number->string))

;; [reducing function] [base] [List-of X] -> [X]
(define (fold r s l)
  (if (empty? l) s
      (r (first l) (fold r s (rest l)))))

;; [reducing function] [base] [List-of X] -> X
(define (f*oldl f e l)
  (foldr f e (reverse l)))

(fold - 1 (build-list 9 +))
(foldl - 1 (build-list 9 +))
(f*oldl - 1 (build-list 9 +))

(fold + 1 (build-list 9 +))
(foldl + 1 (build-list 9 +))
(f*oldl + 1 (build-list 9 +))
