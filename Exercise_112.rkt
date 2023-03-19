;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; (define (missile-or-not? v)
;;   (cond
;;     [(false? v) #true]
;;     [(posn? v) #true]
;;     [else #false]))

(define (missile-or-not? v)
  (cond
    [(or (false? v) (posn? v)) #true]
    [else #false]))

(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 9 2)) #true)
(check-expect (missile-or-not? "yellow") #false)
