;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)
(require htdp/dir)

; String -> Dir.v3
; creates a representation of the a-path directory 
;; (define (create-dir a-path) ...)

(define L (create-dir "/var/log/")) ; on Linux

(define (du dir)
  (local ((define (all-file-size d)
            (foldl + 0 (map (λ (f) (file-size f)) (dir-files d))))
          (define (walk-dirs dir)
            (for/sum ([d (dir-dirs dir)])
              (+ 1 (all-file-size d) (walk-dirs d)))))
    (walk-dirs dir)))

;; du -b /var/log/ -> 1203022346
(check-satisfied (/ 1203022346 (du L))
                 (λ (result) (and (< result 1.05)
                                  (> result 0.95))))
