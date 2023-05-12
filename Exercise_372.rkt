;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define BT (circle 5 'solid 'blue))

(define (list-of-attributes? x)
  (if (empty? x) #true (cons? (first x))))

(define (xexpr-content xexpr)
  (match xexpr
    ['() '()]
    [(cons (? symbol?) (cons (? list-of-attributes?) body)) body]
    [(cons (? symbol?) body) body]
    [_ (error "xexpr-content")]))

(define (word-text xword)
  (match xword
    [(list word (list (list text MATCH)))
     (if (string? MATCH) MATCH (error "NOT a XWord"))]
    [_ (error "NOT a XWord")]))

(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (text a-word 12 'blue)))
    (beside/align 'center BT item)))

(check-expect (render-item1 '(li (word ((text "Hello World")))))
              (beside/align 'center BT (text "Hello World" 12 "blue")))

