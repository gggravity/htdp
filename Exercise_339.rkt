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


(define (list-dir dir)
  (local ((define (file-name-list d)
            (map (λ (f) (file-name f)) (dir-files d)))
          (define (file-name-string d)
            (map string-append (file-name-list d)))
          (define (walk-dirs dir)
            (for/list ([d (dir-dirs dir)])
              (cons (dir-name d) (cons (file-name-string d) (walk-dirs d))))))
    (cons (dir-name dir) (cons (file-name-string dir) (walk-dirs dir)))))

;; (list-dir L)

(define (find-test? dir file)
  (local ((define (file-name-list d)
            (map (λ (f) (file-name f)) (dir-files d)))
          (define (file-match? d)
            (> (length (filter (λ (f) (string=? f file)) (file-name-list d))) 0))
          (define (walk-dirs dir)
            (for/list ([d (dir-dirs dir)])
              (cons (file-match? d) (walk-dirs d)))))
    (cons (file-match? dir) (walk-dirs dir))))

;; (find-test? L "apport.log")
;; (find-test? L "sa26")

(define (find? dir file)
  (or
   (ormap
    (λ (f) (string=? file (file-name f)))
    (dir-files dir))
   (ormap
    (λ (d) (find? d file))
    (dir-dirs dir))))

(check-expect (find? L "apport.log") #true)
(check-expect (find? L "sa26") #true)
(check-expect (find? L "a38") #false)
