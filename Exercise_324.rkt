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

(define N99 (make-node 99 'a99 NONE NONE))
(define N95 (make-node 95 'a95 NONE N99))
(define N77 (make-node 77 'a77 NONE NONE))
(define N24 (make-node 24 'a24 NONE NONE))
(define N10 (make-node 10 'a10 NONE NONE))
(define N15 (make-node 15 'a15 N10 N24))
(define N89 (make-node 89 'a89 N77 N95))
(define N29 (make-node 29 'a29 N15 NONE))
(define ROOT (make-node 63 'a63 N29 N89))

(define (inorder btree)
  (if (equal? btree NONE) '()
      (append (inorder (node-left  btree))
              (list (node-ssn btree))
              (inorder (node-right btree)))))

(check-expect (inorder ROOT) '(10 15 24 29 63 77 89 95 99))
