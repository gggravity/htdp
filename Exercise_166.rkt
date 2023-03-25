;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define pay_pr_hour 100)

;; Number -> Number
;; computes the wage for h hours of work
(define (wage h)
  (* pay_pr_hour h))

;; List-of-numbers -> List-of-numbers
;; computes the weekly wages for teh weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [(>= (first whrs) 100) (error "long working hours detected")]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (wage 28)  '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (wage 4) (cons (wage 2) '())))
(check-error (wage* (cons 128 '())) "long working hours detected") 
(check-error (wage* (cons 4 (cons 222 '()))) "long working hours detected")

(define-struct work [employee rate hours])
;; A (piece of) Work is a structure:
;;  (make-work String Number Number)
;; interpretation (make-work n r h) combines the name
;; with the pay rate r and the number of hours h

;; Low (short for list of work) is one of;
;; -- '()
;; -- (cons Work Low)
;; interpretation an instance of Low represent the
;; hours worked for a numner of employees

(define low1 (cons (make-work "Robby" 11.95 39) '()))
(define low2 (cons (make-work "Mathew" 12.95 45) (cons (make-work "Robby" 11.95 39) '())))

;; Work -> Number
;; computes the wage for h hours of work
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

;; List-of-work -> List-of-pay
;; computes the weekly wages for the weekly hours
(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(>= (work-hours (first an-low)) 100) (error "long working hours detected")]
    [else (cons
           (wage.v2 (first an-low))
           (wage*.v2 (rest an-low))
           )]))

(check-expect (wage*.v2 (cons (make-work "Robby" 11.95 39) '())) (cons (* 11.95 39) '()))


(define-struct paycheck [employee amount])

;; Work -> Number
;; computes the wage for h hours of work
(define (wage.v3 w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))

;; List-of-work -> List-of-paychecks
;; computes the weekly wages for the weekly hours
(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(>= (work-hours (first an-low)) 100) (error "long working hours detected")]
    [else (cons
           (wage.v3 (first an-low))
           (wage*.v3 (rest an-low))
           )]))

(check-expect (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
              (cons (make-paycheck "Robby" (* 11.95 39)) '()))

(define-struct work-paycheck-map [work paycheck])

(define (create-work-paycheck-map an-low an-lop)
  (cond
    [(empty? an-low) '()]
    [else (cons
           (make-work-paycheck-map
            (first an-low)
            (first an-lop))
           (create-work-paycheck-map (rest an-low) (rest an-lop))
           )]))

(define lop2 (wage*.v3 low2))
(create-work-paycheck-map low2 lop2) 

