;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

;; (make-node 15 'd NONE (make-node 24 'i NONE NONE))
;; (make-node 15 'd (make-node 87 'h NONE NONE) NONE)

(define N99 (make-node 99 'a99 NONE NONE))
(define N95 (make-node 95 'a95 NONE N99))
(define N77 (make-node 77 'a77 NONE NONE))
(define N24 (make-node 24 'a24 NONE NONE))
(define N10 (make-node 10 'a10 NONE NONE))
(define N15 (make-node 15 'a15 N10 N24))
(define N89 (make-node 89 'a89 N77 N95))
(define N29 (make-node 29 'a29 N15 NONE))
(define ROOT (make-node 63 'a63 N29 N89))

(define (contains-bt? btree name)
  (if (equal? btree NONE) #false
      (or (equal? (node-name btree) name)
          (contains-bt? (node-left btree) name)
          (contains-bt? (node-right btree) name))))

(check-expect (contains-bt? ROOT 'a96) #false)
(check-expect (contains-bt? ROOT 'a99) #true)
(check-expect (contains-bt? ROOT 'a63) #true)
(check-expect (contains-bt? ROOT 'a38) #false)
