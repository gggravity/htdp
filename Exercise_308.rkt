;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(check-expect (match 4
                ['four  1]
                ["four" 2]
                [#true  3]
                [4      "hello world"])
              "hello world")

(check-expect (match 1
                [3 "one"]
                [x (+ x 3)])
              4)

(check-expect (match (cons 1 '())
                [(cons head tail) "two"] ; match the first, both matches
                [(cons 1 tail) "one"])
              "two")

(check-expect (match (cons 2 '())
                [(cons 1 tail) tail]
                [(cons head tail) head])
              2)

(define p (make-posn 3 4))

(check-expect (match p
                [(posn x y) (sqrt (+ (sqr x) (sqr y)))])
 (sqrt (+ (sqr 3) (sqr 4))))

(define-struct phone [area switch four])

(check-expect (match (make-phone 713 664 9993)
                [(phone x y z) (+ x y z)])
              (+ 713 664 9993))

(check-expect (match (cons (make-phone 713 664 9993) '())
                [(cons (phone area-code 664 9993) tail)
                 area-code])
              713)

(check-expect (match (make-phone 713 664 9993)
                [(phone area-code 664 9993)
                 area-code])
              713)

(check-expect (match (cons 1 '())
                [(cons (? symbol?) tail) tail]
                [(cons head tail) "test"])
              "test")

(check-expect (match (cons 'a '())
                [(cons (? symbol?) tail) "another"]
                [(cons head tail) "test"])
              "another")

; [Non-empty-list X] -> X
; retrieves the last item of ne-l 

(check-expect (last-item '(a b c)) 'c)
(check-error (last-item '()))

(define (last-item ne-l)
  (match ne-l
    [(cons lst '()) lst]
    [(cons fst rst) (last-item rst)]))

;; NELoP -> Posn
;; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last (rest p))]))


(check-expect (last '(a b c)) (last-item '(a b c)))

(define-struct layer [color doll])
; An RD.v2 (short for Russian doll) is one of: 
; – "doll"
; – (make-layer String RD.v2)

; RD.v2 -> N
; how many dolls are a part of an-rd 

(check-expect (depth (make-layer "red" "doll")) 1)

(define (depth a-doll)
  (match a-doll
    ["doll" 0]
    [(layer c inside) (+ (depth inside) 1)]))

; [List-of Posn] -> [List-of Posn] 
; moves each object right by delta-x pixels

(define input  `(,(make-posn 1 1) ,(make-posn 10 14)))
(define expect `(,(make-posn 4 1) ,(make-posn 13 14)))

(check-expect (move-right input 3) expect)

(define (move-right lop delta-x)
  (for/list ((p lop))
    (match p
      [(posn x y) (make-posn (+ x delta-x) y)])))


(define (move-right2 lop delta-x)
  (for/list ([p lop])
    (make-posn (+ (posn-x p) delta-x) (posn-y p))))

(check-expect (move-right2 input 3) expect)

(define (move-right3 lop delta-x)
  (cond
    [(empty? lop) '()]
    [else (cons (make-posn (+ (posn-x (first lop)) delta-x)
                           (posn-y (first lop)))
                (move-right3 (rest lop) delta-x))]))

(check-expect (move-right3 input 3) expect)


(define phone-list (list (make-phone 713 664 9993)
                         (make-phone 713 664 9993)
                         (make-phone 713 664 9993)
                         (make-phone 713 664 9993)
                         (make-phone 713 664 9993)))

(define (replace lop)
  (for/list ((p lop))
    (match (make-phone 713 664 9993)
      [(phone 713 y z) (make-phone 281 y z)]
      [(phone x y z) (make-phone x y z)])))

(check-expect (replace phone-list) (list (make-phone 281 664 9993)
                                         (make-phone 281 664 9993)
                                         (make-phone 281 664 9993)
                                         (make-phone 281 664 9993)
                                         (make-phone 281 664 9993)))

