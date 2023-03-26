;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(define line1 (cons "pale" (cons "blue" (cons "dot" '()))))
(define word1 (cons "p" (cons "a" (cons "l" (cons "e" '())))))

;; 1String -> String
;; converts the given 1String into a String
(define (code1 c)
  (number->string (string->int c)))

(check-expect (code1 "z") "122")

;; 1String -> String
;; converts the given 1String to a 3-letter numeric String

(define (encode-letter s)
  (cond
    [(string=? s " ") " "]
    [(string=? s "\n") "\n"]
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10) (string-append "00" (code1 s))]
    [(< (string->int s) 100) (string-append "0" (code1 s))]))

(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t") (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a") (string-append "0" (code1 "a")))

(define (encode word) ;; need to process the letters
  (if (empty? word) '() 
      (cons (encode-letter (first word))
            (encode (rest word) ))))

(define (new-filename filename)
  (string-append "encoded-" filename))

(define (print-list lol)
  (cond
    [(empty? lol) ""]
    [else (cons (first lol) (print-list (rest lol)))]))

(define (merge l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) "" (merge (rest l)))]))


(define (process-file filename)
  (write-file (new-filename filename)
              (merge (encode (explode (read-file filename))))
              ))
  

(process-file "ttt-org.txt")


