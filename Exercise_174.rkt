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
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10) (string-append "00" (code1 s))]
    [(< (string->int s) 100) (string-append "0" (code1 s))]))

(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t") (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a") (string-append "0" (code1 "a")))

(define (encode-word word) ;; need to process the letters
  (if (empty? word) '() 
      (cons (encode-letter (substring (implode word) 0 1))
            (encode-word (explode (substring (implode word) 1))))
      ))

(check-expect (encode-word word1) (cons "112" (cons "097" (cons "108" (cons "101" '())))))

(define (encode-line line)
  (if (empty? line) '() 
      (cons (encode-word (explode (first line))) (encode-line (rest line)))))

(check-expect (encode-line line1)
              (cons
               (cons "112" (cons "097" (cons "108" (cons "101" '()))))
               (cons
                (cons "098" (cons "108" (cons "117" (cons "101" '()))))
                (cons
                 (cons "100" (cons "111" (cons "116" '()))) '()))))

(define (encode-file f)
  (cond
    [(empty? f) '()]
    [else (cons (encode-line (first f)) (encode-file (rest f)))]))

(define (collapse-line line)
  (cond
    [(empty? line) ""]
    [(empty? (rest line)) (first line)]
    [else (string-append (first line) " " (collapse-line (rest line)))]))

(define (collapse-lol lol)
  (cond
    [(empty? lol) ""]
    [else (string-append (collapse-line (first lol)) "\n" (collapse-lol (rest lol)))]))

(define (new-filename filename)
  (string-append "encoded-" filename))

(define (process-file filename)
  (write-file (new-filename filename)
              (encode-file (read-words/line filename))
              ))

;; (process-file "ttt-org.txt")

(encode-file (read-words/line "ttt-org.txt"))

