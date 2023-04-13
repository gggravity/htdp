;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

; An Atom is one of:
; – Number
; – String
; – Symbol

(define (atom? value)
  (or (number? value)
      (string? value)
      (symbol? value)))

(define b 123)

(check-expect (atom? 123) #true)
(check-expect (atom? "hello world") #true)
(check-expect (atom? 'a) #true)
(check-expect (atom? b) #true)
(check-expect (atom? '(1 2 3)) #false)
(check-expect (atom? '("hello" "world")) #false)

;; ; S-expr Symbol -> N 
;; ; counts all occurrences of sy in sexp 
;; (define (count sexp sy)
;;   (cond
;;     [(atom? sexp) (count-atom sexp sy)]
;;     [else (count-sl sexp sy)]))

;; ; SL Symbol -> N 
;; ; counts all occurrences of sy in sl 
;; (define (count-sl sl sy)
;;   (cond
;;     [(empty? sl) 0]
;;     [else
;;      (+ (count (first sl) sy) (count-sl (rest sl) sy))]))

;; ; Atom Symbol -> N 
;; ; counts all occurrences of sy in at 
;; (define (count-atom at sy)
;;   (cond
;;     [(number? at) 0]
;;     [(string? at) 0]
;;     [(symbol? at) (if (symbol=? at sy) 1 0)]))



(define (count sexp sy)
  (local ((define (count-sl sl)
            (cond
               [(empty? sl) 0]
               [else
                (+ (count (first sl) sy) (count-sl (rest sl)))]))
          (define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)])))
    (cond
      [(atom? sexp) (count-atom sexp)]
      [else (count-sl sexp)])))

(check-expect (count '(a b c c e (a c c b)) 'c) 4)
(check-expect (count '(a a a a a) 'c) 0)


(define (depth list-of-sexp)
  (local ((define (count-sl sl)
            (cond
              [(empty? sl) 1]
              [else
               (+ (depth (first sl)) (count-sl (rest sl)))])))
    (cond
      [(atom? list-of-sexp) 0]
      [else (count-sl list-of-sexp)])))

(check-expect (depth '(a b c c e (a c (a b) c b))) 3)
(check-expect (depth '(a a a a a)) 1)
(check-expect (depth '(((((((((())))))))))) 10)
(check-expect (depth '(((((((((((((((())))))))))(((())))))))))) 20)

