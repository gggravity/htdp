;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)


(define-struct file [name size content])
;; A File.v3 is a structure: 
;; (make-file String N String)


(define-struct dir [name dirs files])
;; (define-struct dir [name readability content])

(define Text-files (list (make-file "part1" 99 "")
                         (make-file "part2" 52 "")
                         (make-file "part3" 17 "")))

(define Code-files (list (make-file "Hang" 8 "")
                         (make-file "draw" 2 "")))

(define Docs-files (list (make-file "read!" 19 "")))

(define TS-files (list (make-file "read!" 10 "")))

(define d1
  (make-dir "TS" (list (make-dir "Text" '() Text-files)
                       (make-dir "Libs" (list (make-dir "Code" '() Code-files)
					      (make-dir "Docs" '() Docs-files)) '()))
	    TS-files))


(define (how-many-text dir)
  (local ((define (append-count d)
            (string-append "Files: " (number->string (length (dir-files d)))))
          (define (walk-dirs dir)
            (for/list ([d (dir-dirs dir)])
              (cons (dir-name d) (cons (append-count d) (walk-dirs d))))))
    (cons (dir-name dir) (cons (append-count dir) (walk-dirs dir)))))

(check-expect (how-many-text d1) '("TS" "Files: 1"
                                        ("Text" "Files: 3")
                                        ("Libs" "Files: 0"
                                                ("Code" "Files: 2")
                                                ("Docs" "Files: 1"))))

(define (how-many dir)
  (local ((define (count d)
            (length (dir-files d)))
          (define (walk-dirs dir)
            (for/sum ([d (dir-dirs dir)])
              (+ (count d) (walk-dirs d)))))
    (+ (count dir) (walk-dirs dir))))

(check-expect (how-many d1) 7)