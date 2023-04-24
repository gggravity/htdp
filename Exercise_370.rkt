;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

;; An XWord is '(word ((text String))).

(define w1 '(word ((text "hello"))))
(define w2 '(word ((text "strange"))))
(define w3 '(word ((text "world"))))
(define nw1 '(word ((text 123))))

(define (word? xword)
  (match xword
    [(list word (list (list text MATCH))) (string? MATCH)] 
    [_ #false]))

(check-expect (word? w1) #true)
(check-expect (word? w2) #true)
(check-expect (word? w3) #true)
(check-expect (word? nw1) #false)
(check-expect (word? "Hello") #false)

(define (word-text xword)
  (match xword
    [(list word (list (list text MATCH)))
     (if (string? MATCH) MATCH (error "NOT a XWord"))]
    [_ (error "NOT a XWord")]))

(check-expect (word-text w1) "hello")
(check-expect (word-text w2) "strange")
(check-expect (word-text w3) "world")
(check-error (word-text nw1) "NOT a XWord")
(check-error (word-text "Hello") "NOT a XWord")
