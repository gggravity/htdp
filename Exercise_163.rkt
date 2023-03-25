;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; Number -> Number
;; computes the wage for h hours of work
(define (f-to-c degree)
  (* (- degree 32) 5/9))

;; List-of-numbers -> List-of-numbers
;; computes the weekly wages for teh weekly hours
(define (convertFC degrees)
  (cond
    [(empty? degrees) '()]
    [(< (first degrees) -459.67) (error "below absolute zero")]
    [else (cons (f-to-c (first degrees)) (convertFC (rest degrees)))]))

(check-expect (convertFC (cons 1 (cons 100 '()))) (cons (f-to-c 1) (cons (f-to-c 100) '())))
(check-expect (convertFC (cons -100 (cons 200 '()))) (cons (f-to-c -100) (cons (f-to-c 200) '())))
(check-expect (convertFC (cons -10.1 (cons 22.2 '()))) (cons (f-to-c -10.1) (cons (f-to-c 22.2) '())))
(check-error (convertFC (cons -500 (cons 22.2 '()))) "below absolute zero")

