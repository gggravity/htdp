;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

(define-struct file [name size])

(define-struct dir [name readability content])

(define d1
  (make-dir "TS" #true
            (list
                   (make-dir "Text" #true (list
                                           (make-file "part1" 99)
                                           (make-file "part2" 52)
                                           (make-file "part3" 17)))
                   (make-file "read!" 10)
                   (make-dir "Libs" #true (list
                                           (make-dir "Code" #true (list (make-file "hang" 8)
                                                                        (make-file "draw" 2)))
                                           (make-dir "Docs" #true (list
                                                                   (make-file "read!" 19))))))))

(define (dir-size-list dir)
  (local ((define (d-size d)
            (for/sum ([f d])
              (if (file? f) (file-size f)
                  (d-size (dir-content f))))))
    (d-size (dir-content dir))))

(check-expect (dir-size-list d1) 207)

(define (dir-size-total dir)
  (local ((define (d-size d)
            (for/list ([f d])
              (if (file? f) (file-size f)
                  (d-size (dir-content f))))))
    (d-size (dir-content dir))))

(check-expect (dir-size-total d1) '((99 52 17) 10 ((8 2) (19))))
