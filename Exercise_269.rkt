;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define-struct inventory [name desc acq-price sales-price])

(define inventory-list (list (make-inventory "item-1" "item-1" 101 120)
                             (make-inventory "item-2" "item-2" 12 66)
                             (make-inventory "item-3" "item-3" 19 9)
                             (make-inventory "item-4" "item-4" 14 16)
                             (make-inventory "item-5" "item-5" 40 120)
                             (make-inventory "item-6" "item-6" 10 12)
                             (make-inventory "item-7" "item-7" 120 121)
                             ))

(define (sort-profit loi)
  (local (
          (define (profit item)
            (- (inventory-sales-price item) (inventory-acq-price item)))

          (define (cmp a b)
            (> (profit a) (profit b)))
          )
    (sort loi cmp)
    ))

(check-expect (sort-profit inventory-list)
              (list (make-inventory "item-5" "item-5" 40 120)
                    (make-inventory "item-2" "item-2" 12 66)
                    (make-inventory "item-1" "item-1" 101 120)
                    (make-inventory "item-4" "item-4" 14 16)
                    (make-inventory "item-6" "item-6" 10 12)
                    (make-inventory "item-7" "item-7" 120 121)
                    (make-inventory "item-3" "item-3" 19 9)))

(define (eliminate-expensive ua loi)
  (local ((define (pred item)
            (< (inventory-sales-price item) ua)
            ))
    (filter pred loi)))

(check-expect (eliminate-expensive 20 inventory-list)
              (list (make-inventory "item-3" "item-3" 19 9)
                    (make-inventory "item-4" "item-4" 14 16)
                    (make-inventory "item-6" "item-6" 10 12)))

(define (recall ty loi)
  (local ((define (pred item)
            (not (string=? (inventory-name item) ty))
            ))
    (filter pred loi)))

(check-expect (recall "item-4" inventory-list)
              (list (make-inventory "item-1" "item-1" 101 120)
                    (make-inventory "item-2" "item-2" 12 66)
                    (make-inventory "item-3" "item-3" 19 9)
                    (make-inventory "item-5" "item-5" 40 120)
                    (make-inventory "item-6" "item-6" 10 12)
                    (make-inventory "item-7" "item-7" 120 121)))

(define cheap-inventory (eliminate-expensive 20 inventory-list))

(define inventory-list-cut (list (make-inventory "item-5" "item-5" 40 120)
                                 (make-inventory "item-6" "item-6" 10 12)
                                 (make-inventory "item-7" "item-7" 120 121)))

(define (selection list1 list2)
  (local (
          (define (member-of-list2? item)
            (member? item list2)))
    (filter member-of-list2? list1)))

(check-expect (selection cheap-inventory inventory-list-cut)
              (list (make-inventory "item-6" "item-6" 10 12)))
