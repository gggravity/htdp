;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define-struct email [from date message])
;; An Email Message is a structure:
;;  (make-email String Number String)
;; interpretation (make-email f d m) represent text m
;; sent by f, d secounds after the beginning of time.

(define (email-date>= email1 email2)
 (>= (email-date email1) (email-date email2)))

(define (email-from>= email1 email2)
 (string>=? (email-from email1) (email-from email2)))


;; List-of-email -> List-of-email
;; produces a list sorted by from
(define (sort-email-from> l)
  (cond
    [(empty? l) '()]
    [else (insert-from (first l) (sort-email-from> (rest l)))]
    ))

(check-expect (sort-email-from> '()) '())

(check-expect
 (sort-email-from>
  (list (make-email "Jack" 3 "HI")
        (make-email "Jill" 2 "HI")
        (make-email "John" 11 "HI")))
 (list (make-email "John" 11 "HI")
       (make-email "Jill" 2 "HI")
       (make-email "Jack" 3 "HI")))

;; List-of-email -> List-of-email
;; produces a list sorted by from
(define (sort-email-date> l)
  (cond
    [(empty? l) '()]
    [else (insert-date (first l) (sort-email-date> (rest l)))]
    ))

(check-expect (sort-email-date> '()) '())

(check-expect
 (sort-email-date>
  (list (make-email "A" 3 "1")
        (make-email "B" 2 "2")
        (make-email "C" 11 "3")))
 (list (make-email "C" 11 "3")
       (make-email "A" 3 "1")
       (make-email "B" 2 "2")))

;; Email List-of-emails -> List-of-emails
;; inserts n into the sorted list of emails l
(define (insert-from n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (email-from>= n (first l))
              (cons n l)
              (cons (first l) (insert-from n (rest l)))
              )]))

(check-expect (insert-from (make-email "Jack" 2 "HI") (list (make-email "Jill" 1 "HO")))
              (list (make-email "Jill" 1 "HO") (make-email "Jack" 2 "HI")))

;; Email List-of-emails -> List-of-emails
;; inserts n into the sorted list of emails l
(define (insert-date n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (email-date>= n (first l))
              (cons n l)
              (cons (first l) (insert-date n (rest l)))
              )]))

(check-expect (insert-date (make-email "Jack" 2 "HI") (list (make-email "Jill" 1 "HO")))
              (list (make-email "Jack" 2 "HI") (make-email "Jill" 1 "HO")))

;; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

;; Number List-of-numbers -> Boolean
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [(< n (first alon)) #false]
    [(= n (first alon)) #true]
    [else (search n (rest alon))]))

(search-sorted 2 (list 1 2 3 4 5s 6))

