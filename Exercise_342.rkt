;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)
(require htdp/dir)

; String -> Dir.v3
; creates a representation of the a-path directory 
;; (define (create-dir a-path) ...)

(define L (create-dir "/var/log/")) ; on Linux

; A Path is [List-of String].
; interpretation directions into a directory tree

(define Text-files (list (make-file "part1" 99 "")
                         (make-file "part2" 52 "")
                         (make-file "part3" 17 "")))

(define Code-files (list (make-file "hang" 8 "")
                         (make-file "draw" 2 "")))

(define Docs-files (list (make-file "read!" 19 "")))

(define TS-files (list (make-file "read!" 10 "")))

(define d1
  (make-dir "TS" (list (make-dir "Text" '() Text-files)
                       (make-dir "Libs" (list (make-dir "Code" '() Code-files)
					      (make-dir "Docs" '() Docs-files)) '()))
	    TS-files))


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

(define (find-sub-dir dir name)
  (local ((define contains-file?
            (ormap (λ (f) (string=? name (file-name f))) (dir-files dir)))
          (define walk-dirs
            (for/or ([sub-dir (dir-dirs dir)])
              (find-sub-dir sub-dir name))))
    (if contains-file?
        (dir-name dir)
        walk-dirs)))

(check-expect (find-sub-dir d1 "sa26") #false)
(check-expect (find-sub-dir d1 "read!") "TS")
(check-expect (find-sub-dir d1 "hang") "Code")

(define (find-one-up dir name)
  (local ((define contains-dir?
            (ormap (λ (f) (string=? name (dir-name f))) (dir-dirs dir)))
          (define walk-dirs
            (for/or ([sub-dir (dir-dirs dir)])
              (find-one-up sub-dir name))))
    (if contains-dir?
        (dir-name dir)
        walk-dirs)))


(define (find-fuld-path root path dir name)
  (local ((define new-name (find-one-up dir name)))
    (if (string=? (first path) root) path
        (find-fuld-path root (cons new-name path) dir new-name)
        )))

(check-expect (find-fuld-path "TS" '("Code") d1 "Code") '("TS" "Libs" "Code"))

(define (find dir name)
  (if (find? dir name)
      (local ((define sub-dir (find-sub-dir dir name)))
        (find-fuld-path (dir-name dir) (list sub-dir) dir sub-dir))
      #false
      ))

(check-expect (find d1 "hang") '("TS" "Libs" "Code"))
(check-expect (find d1 "hang!") #false)
(check-expect (find d1 "part3") '("TS" "Text"))
(check-expect (find d1 "read!") '("TS"))

