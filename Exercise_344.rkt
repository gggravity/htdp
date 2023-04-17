;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)
(require htdp/dir)

; String -> Dir.v3
; creates a representation of the a-path directory 
;; (define (create-dir a-path) ...)

;; (define L (create-dir "/var/log/")) ; on Linux

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

;; (check-expect (find? L "apport.log") #true)
;; (check-expect (find? L "sa26") #true)
;; (check-expect (find? L "a38") #false)

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

(define (find-filepath dir name)
  (local ((define (find-path dir name path)
            (local ((define contains-file?
                      (ormap (λ (f) (string=? name (file-name f))) (dir-files dir)))
                    (define (walk-dirs dir)
                      (for/or ([sub-dir (dir-dirs dir)])
                        (find-path sub-dir name (cons (dir-name sub-dir) path)))))
              (if contains-file? path (walk-dirs dir))
              )))
    (reverse (find-path dir name (list (dir-name dir))))
    ))

(check-expect (find-filepath d1 "hang") '("TS" "Libs" "Code"))

(define (find-all dir name)
  (local ((define (list-dirs dir name path)
            (local ((define contains-file?
                      (ormap (λ (f) (string=? name (file-name f))) (dir-files dir)))
                    (define (walk-dirs dir)
                      (for/or ([sub-dir (dir-dirs dir)])
                        (list-dirs sub-dir name (cons (dir-name sub-dir) path)))))
              (if contains-file?
                  (if (false? (walk-dirs dir))
                      (list path) (cons path (walk-dirs dir)))
                  (walk-dirs dir)
                  ))))
    (map reverse (list-dirs dir name (list (dir-name dir))))          
    ))

(check-expect (find-all d1 "read!") '(("TS") ("TS" "Libs" "Docs")))

(define (find-all2 dir name)
  (local
      ((define contains-file?
         (ormap (λ (f) (string=? name (file-name f))) (dir-files dir)))

       (define walk-dirs
         (for*/list ([d  (dir-dirs dir)]
                     [path (find-all2 d name)])
           (cons (dir-name dir) path))))

    (if contains-file?
        (cons (list (dir-name dir)) walk-dirs)
        walk-dirs)))

(check-expect (find-all d1 "read!") (find-all2 d1 "read!"))


(define (ls-R dir)
  (local ((define list-files (map (λ (f) (file-name f)) (dir-files dir)))
          (define walk-dirs
            (for*/list ([d  (dir-dirs dir)]
                        [path (ls-R d)])
              (cons (dir-name dir) path))))
    (cons (list (dir-name dir) list-files) walk-dirs)))

;; (ls-R d1)
(check-expect (ls-R d1) '(("TS" ("read!"))
                          ("TS" "Text" ("part1" "part2" "part3"))
                          ("TS" "Libs" ())
                          ("TS" "Libs" "Code" ("hang" "draw"))
                          ("TS" "Libs" "Docs" ("read!"))))

(define (find-all-344 dir name)
  (local
      ((define contains-file?
         (ormap (λ (f) (string=? name (file-name f))) (dir-files dir)))

       (define contains-dir?
         (ormap (λ (d) (string=? name (dir-name d))) (dir-dirs dir)))

       (define walk-dirs
         (for*/list ([d  (dir-dirs dir)]
                     [path (find-all-344 d name)])
           (cons (dir-name dir) path))))

    (if (or contains-file?
            contains-dir?)
        (cons (list (dir-name dir) name) walk-dirs)
        walk-dirs)))

(check-expect (find-all-344 d1 "read!") '(("TS" "read!") ("TS" "Libs" "Docs" "read!")))
(check-expect (find-all-344 d1 "Code") '(("TS" "Libs" "Code")))
(check-expect (find-all-344 d1 "hang") '(("TS" "Libs" "Code" "hang")))
