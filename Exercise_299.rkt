;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (valid? s)
  (s e))

(define (create-set l)
  l)

(define (create-finite-set a b)
  (build-list (+ (- b a) 1) (λ (x) (+ a (+ x)))))

(define (is-finite-set? a b)
  (λ (result)
    (equal? result (create-finite-set a b))))

(check-satisfied '(10 11 12 13 14 15 16 17 18 19 20) (is-finite-set? 10 20))

(define l1 (build-list 10 add1))
(define s1 (create-set l1))

(check-expect (create-set l1) '(1 2 3 4 5 6 7 8 9 10))

(define (add-element elem set)
  (if (member? elem set) #false
      (append (list elem) set)))

(define (added-to-set elem)
  (λ (result)
    (if (and (false? result) (eq? elem result)) #true
        (member? elem result))))

(check-satisfied (add-element 20 s1) (added-to-set 20))
(check-satisfied (add-element 10 s1) (added-to-set #false))

(define (union set1 set2)
  (cond [(empty? set1) set2]
        [(empty? set2) set1]
        [(member (first set1) set2) (union (rest set1) set2)]
        [else (cons (first set1) (union (rest set1) set2))]))

(define (is-union? set1 set2)
  (λ (result)
     (equal? result (union set1 set2))))

(check-satisfied '(1 2 3 4 5) (is-union? '(1 2 3) '(3 4 5)))

(define (intersect set1 set2)
  (if (empty? set1) '()
      (if (member (first set1) set2)
          (cons (first set1) (intersect (rest set1) set2))
          (intersect (rest set1) set2))))

(define (is-intersect? set1 set2)
  (λ (result)
    (equal? result (intersect set1 set2))))

(check-satisfied '(3) (is-intersect? '(1 2 3) '(3 4 5)))

(define (to-check x)
  (if (eq? x 1) 1
      #false))

(define (valid x)
  (λ (result) (eq? x result)))

(check-satisfied (to-check 1) (valid 1))
(check-satisfied (to-check 2) (valid #false))
