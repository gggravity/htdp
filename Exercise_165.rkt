;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; Number -> Number
;; change "robot" to "r2d2" 
(define (rotot-to-r2d2 s)
  (if (string=? s "robot") "r2d2" s))

;; List-of-strings -> List-of-strings
;; change "robot" to "r2d2" for a list-of-strings 
(define (subst-robot lot)
  (cond
    [(empty? lot) '()]
    [else (cons (rotot-to-r2d2 (first lot)) (subst-robot (rest lot)))]))

(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "hello" (cons "world" '()))) (cons "hello" (cons "world" '())))
(check-expect (subst-robot (cons "hello" (cons "robot" '()))) (cons "hello" (cons "r2d2" '())))
(check-expect (subst-robot (cons "robot" (cons "world" '()))) (cons "r2d2" (cons "world" '())))

