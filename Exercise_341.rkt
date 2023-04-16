;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)
(require htdp/dir)

; String -> Dir.v3
; creates a representation of the a-path directory 
;; (define (create-dir a-path) ...)

(define L (create-dir "/var/log/")) ; on Linux

(define (du1 dir)
  (local ((define (all-file-size d)
            (for/sum ([f (dir-files d)])
              (file-size f)))
          (define (walk-dirs dir)
            (for/sum ([d (dir-dirs dir)])
              (+ 1 (du1 d)))))
    (+ (all-file-size dir)
       (walk-dirs dir))
    ))

;; du -b /var/log/ -> 1203022346
(check-satisfied (/ 1203022346 (du1 L))
                 (λ (result) (and (< result 1.05)
                                  (> result 0.95))))

(define (du2 dir)
  (+
   (for/sum ([f (dir-files dir)])
     (file-size f))
   (for/sum ([d (dir-dirs dir)])
     (add1 (du2 d)))
   ))

(check-satisfied (/ 1203022346 (du2 L))
                 (λ (result) (and (< result 1.05)
                                  (> result 0.95))))

(check-expect (du1 L) (du2 L))
