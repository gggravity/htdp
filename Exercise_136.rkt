;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct pair [left right])
;; A ConsPair is a structure:
;; (make-pair Any Any)

;; ConsOrEmpty -> Any
;; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

;; ConsOrEmpty -> Any
;; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest  "...")
      (pair-right a-list)))

;; Any Any -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

(our-first (our-cons "a" '())) ; == "a"

(our-rest (our-cons "a" '())) ; == '()
