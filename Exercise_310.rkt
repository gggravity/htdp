;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define-struct no-parent [])

(define-struct child [father mother name date eyes])
;; An FT (short for family tree) is one of: 
;; – (make-no-parent)
;; – (make-child FT FT String N String)

(define NP (make-no-parent))
;; An FT is one of: 
;; – NP
;; – (make-child FT FT String N String)

;; Oldest Generation:

(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))

;; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))

;; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))


;; FT -> Boolean
;; does an-ftree contain a child
;; structure with "blue" in the eyes field

(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Gustav) #true)

(define (blue-eyed-child? an-ftree)
  (cond
   [(no-parent? an-ftree) #false]
   [else (or (string=? (child-eyes an-ftree) "blue")
             (blue-eyed-child? (child-father an-ftree))
             (blue-eyed-child? (child-mother an-ftree)))]))

(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Gustav) #true)


(define (count-persons an-ftree)
  (cond
    [(no-parent? an-ftree) 0]
    [else (+ 1
             (count-persons (child-father an-ftree))
             (count-persons (child-mother an-ftree)))]))

(check-expect (count-persons Carl) 1)
(check-expect (count-persons Bettina) 1)
(check-expect (count-persons Adam) 3)
(check-expect (count-persons Dave) 3)
(check-expect (count-persons Eva) 3)
(check-expect (count-persons Fred) 1)
(check-expect (count-persons Gustav) 5)

(define (count-tree tree)
  (match tree
    [(no-parent) 0]
    [(child f m n d e) (+ 1 (count-tree f) (count-tree m))]))

(check-expect (count-persons Carl) (count-tree Carl))
(check-expect (count-persons Bettina) (count-tree Bettina))
(check-expect (count-persons Adam) (count-tree Adam))
(check-expect (count-persons Dave) (count-tree Dave))
(check-expect (count-persons Eva) (count-tree Eva))
(check-expect (count-persons Fred) (count-tree Fred))
(check-expect (count-persons Gustav) (count-tree Gustav))


