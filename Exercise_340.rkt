;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)
(require htdp/dir)

; String -> Dir.v3
; creates a representation of the a-path directory 
;; (define (create-dir a-path) ...)

(define L (create-dir "/var/log/")) ; on Linux

;; (create-dir "/var/log/")

(define (how-many-text dir)
  (local ((define (append-count d)
            (string-append "Files: " (number->string (length (dir-files d)))))
          (define (walk-dirs dir)
            (for/list ([d (dir-dirs dir)])
              (cons (dir-name d) (cons (append-count d) (walk-dirs d))))))
    (cons (dir-name dir) (cons (append-count dir) (walk-dirs dir)))))


(define (how-many dir)
  (local ((define (count d)
            (length (dir-files d)))
          (define (walk-dirs dir)
            (for/sum ([d (dir-dirs dir)])
              (+ (count d) (walk-dirs d)))))
    (+ (count dir) (walk-dirs dir))))

(check-expect (how-many L) 144)


(define (ls-all dir)
  (local ((define (file-name-list d)
            (map (λ (f) (file-name f)) (dir-files d)))
          (define (file-name-string d)
            (map string-append (file-name-list d)))
          (define (walk-dirs dir)
            (for/list ([d (dir-dirs dir)])
              (cons (dir-name d) (cons (file-name-string d) (walk-dirs d))))))
    (cons (dir-name dir) (cons (file-name-string dir) (walk-dirs dir)))))

;; (ls-all L)

(define (ls dir)
  (append
   (list (map (λ (f) (dir-name f)) (dir-dirs dir)))
   (list (map (λ (f) (file-name f)) (dir-files dir)))))

(ls L)

