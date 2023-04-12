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

(define (list-ages tree year)
  (match tree
    [(no-parent) '()]
    [(child f m n d e)
     (cons (- year d) (append (list-ages f year) (list-ages m year)) )
     ]))

(check-expect (list-ages Carl 1930) '(4))
(check-expect (list-ages Adam 1955) '(5 29 29))
(check-expect (list-ages Gustav 1990) '(2 24 25 64 64))

(define (average-age-tree tree year)
  ((λ (l)
     (/ (foldl + 0 l) (length l)))
   (list-ages tree year)))

(check-expect (average-age-tree Gustav 1990) 35.8)

(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

(define (list-ages-forest forest year)
  (foldr append '()
         (for/list ([tree forest])
           (list-ages tree year))))

(define (average-age-forest forest year)
  ((λ (l)
     (/ (foldl + 0 l) (length l)))
   (list-ages-forest forest year)))

(check-expect (average-age-forest ff1 1990) 64)
(check-expect (average-age-forest ff2 1990) 44.25)
(check-expect (average-age-forest ff3 1990) 48.2)
