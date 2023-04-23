;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define a0 '((initial "X")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

;; (define (list-of-attributes? x)
;;   (cond
;;     [(empty? x) #true]
;;     [else
;;      (local ((define possible-attribute (first x)))
;;        (cons? possible-attribute))]))

;; list of attributes -> Boolean
(define (list-of-attributes? x)
  (if (empty? x) #true (cons? (first x))))

;; (define (xexpr-attr xe)
;;   (local ((define optional-loa+content (rest xe)))
;;     (cond
;;       [(empty? optional-loa+content) '()]
;;       [else
;;        (local ((define loa-or-x
;;                  (first optional-loa+content)))
;;          (if (list-of-attributes? loa-or-x)
;;              loa-or-x
;;              '()))])))


(define (xexpr-attr xexpr)
(if (empty? (rest xexpr)) '()
    (if (list-of-attributes? (second xexpr)) (second xexpr) '())
    ))

(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) '((initial "X")))
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) '((initial "X")))

;; (define (xexpr-name xexpr)
;;   (if (empty? (rest xexpr)) '()
;;       (if (symbol? (first xexpr)) (first xexpr) "ERROR")
;;       ))

(define (xexpr-name xexpr)
  (match xexpr
    ['() '()]
    [(cons (? symbol?) _) (first xexpr)]
    [_ (error "xexpr-name")]
    ))

(check-expect (xexpr-name `(machine ,a0 (action) (action))) 'machine)

(define (xexpr-content xexpr)
  (match xexpr
    ['() '()]
    [(cons (? symbol?) (cons (? list-of-attributes?) body)) body]
    [(cons (? symbol?) body) body]
    [_ (error "xexpr-content")]
    ))

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))

(define loa1 '((initial "red") (state "green") (next "yellow") (another another)))

(define (find-attr loa sym)
  (match (assq sym loa)
    [#false #false]
    [result (if (string? (second result)) (second result) #false)]))

(check-expect (find-attr loa1 'initial) "red")
(check-expect (find-attr loa1 'state) "green")
(check-expect (find-attr loa1 'next) "yellow")
(check-expect (find-attr loa1 'another) #false)
(check-expect (find-attr loa1 'x) #false)


