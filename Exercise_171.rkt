;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(read-file "ttt.txt")

;; String -> String
;; produces the content of file f as a string
;;  (define (read-file f) ...)

;; String -> List-of-string
;; produces the content of file f as a list of strings, one per line
;;  (define (read-lines f) ...)

;; String -> List-of-string
;; produces the content of file f as a list of strings, one per word
;;  (define (read-words f) ...)

;; String -> List-of-list-of-string
;; produces the content of file f as a list of list of
;; strings, one list per line and one string per word
;;  (define (read-words/line f) ...)

;; The above functions consume the name of a file as a String
;; argument. If the specified file does not exists in the
;; same folder as the program, they signal an error.


(check-expect (read-lines "ttt.txt")
              (cons "TTT"
                    (cons ""
                          (cons "put up"
                                (cons "easy to see"
                                      '())))))

(check-expect (read-words "ttt.txt")
              (cons "TTT"
                    (cons "put"
                          (cons "up"
                                (cons "easy"
                                      (cons "to"
                                            (cons "see" '())
                                            ))))))

(check-expect (read-words/line "ttt.txt")
              (cons (cons "TTT" '())
                    (cons '()
                          (cons (cons "put" (cons "up" '()))
                                (cons (cons "easy" (cons "to" (cons "see" '())))
                                      '())))))
