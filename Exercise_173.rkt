;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(define line1 (cons "hello" (cons "world" '())))
(define line2 (cons "pale" (cons "blue" (cons "dot" '()))))
(define line3 (cons "pale" (cons "an" (cons "dot" '()))))

(define (word-test line)
  (if (not (or (string=? (first line) "a")
               (string=? (first line) "an")
               (string=? (first line) "the")))
      (cons (first line) (clean-line (rest line)))
      (clean-line (rest line))))

(define (clean-line line)
  (if (empty? line) '() (word-test line)))

(check-expect (clean-line line1) line1)
(check-expect (clean-line line2) line2)
(check-expect (clean-line line3) (cons "pale" (cons "dot" '())))

(define file1 (cons line1 (cons line2 (cons line3 '()))))

(define (clean-file f)
  (cond
    [(empty? f) '()]
    [else (cons (clean-line (first f)) (clean-file (rest f)))]))

(check-expect (clean-file '()) '())
(check-expect (clean-file file1) (cons line1 (cons line2 (cons (clean-line line3) '()))))

(define (new-filename filename)
  (string-append "no-articles-" filename))

(check-expect (new-filename "ttt.txt") "no-articles-ttt.txt")

(define (collapse-line line)
  (cond
    [(empty? line) ""]
    [(empty? (rest line)) (first line)]
    [else (string-append (first line) " " (collapse-line (rest line)))]))

(check-expect (collapse-line '()) "")
(check-expect (collapse-line line1) "hello world")
(check-expect (collapse-line line2) "pale blue dot")

(define (collapse-lol lol)
  (cond
    [(empty? lol) ""]
    [else (string-append (collapse-line (first lol)) "\n" (collapse-lol (rest lol)))]))

(define (process-file filename)
  (write-file (new-filename filename)
              (collapse-lol (clean-file (read-words/line filename)))
              ))

(process-file "ttt-org.txt")

;; (clean-file (read-words/line "ttt-org.txt"))


