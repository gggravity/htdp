;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; (define (cat l)
;;   (cond
;;     [(empty? l) ""]
;;     [else (string-append (first l) (cat (rest l)))]))

(define (cat l)
  (if (empty? l) ""
      (string-append (first l) (cat (rest l)))))

(check-expect (cat '() ) "")

(check-expect (cat (cons "A" '()) ) "A")

(check-expect (cat (cons "" '()) ) "")

(check-expect (cat (cons "A" (cons "B" (cons "C" '() )))) "ABC")

(check-expect (cat (cons "C" (cons "B" (cons "A" '() )))) "CBA")

(check-expect (cat (cons "A" (cons "" (cons "A" '() )))) "AA")
