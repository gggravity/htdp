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

(define (blue-eyed-ancestor? t)
  (cond
    [(no-parent? t) #false]
    [(and (not (no-parent? (child-father t)))
          (string=? (child-eyes (child-father t)) "blue")) #true]
    [(and (not (no-parent? (child-mother t)))
          (string=? (child-eyes (child-mother t)) "blue")) #true]
    [else
     (or
      (blue-eyed-ancestor? (child-father t))
      (blue-eyed-ancestor? (child-mother t)))]))

(check-expect (blue-eyed-ancestor? Eva) #false)
(check-expect (blue-eyed-ancestor? Gustav) #true)

(define (blue-eyed-ancestor?2 tree)
  (match tree
    [(no-parent) #false]
    [(child (child _ _ _ _ "blue") _ _ _ _) #true]
    [(child _ (child _ _ _ _ "blue") _ _ _) #true]
    [(child father mother _ _ _) 
     (or 
      (blue-eyed-ancestor?2 father)
      (blue-eyed-ancestor?2 mother)
      )]))

(check-expect (blue-eyed-ancestor?2 Eva) #false)
(check-expect (blue-eyed-ancestor?2 Gustav) #true)
