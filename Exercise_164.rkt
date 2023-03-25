;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; Number -> Number
;; converts dollers into euros
(define ($-to-€ fx)
  (* 0.9291 fx))

;; List-of-numbers -> List-of-numbers
;; converts a list of dollers into a list of euros
(define (convert-euro fx)
  (cond
    [(empty? fx) '()]
    [else (cons ($-to-€ (first fx)) (convert-euro (rest fx)))]))

(check-expect (convert-euro (cons 1 (cons 100 '()))) (cons ($-to-€ 1) (cons ($-to-€ 100) '())))
(check-expect (convert-euro (cons -100 (cons 200 '()))) (cons ($-to-€ -100) (cons ($-to-€ 200) '())))
(check-expect (convert-euro (cons -10.1 (cons 22.2 '()))) (cons ($-to-€ -10.1) (cons ($-to-€ 22.2) '())))

