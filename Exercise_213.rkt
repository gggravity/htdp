g;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/batch-io)

(define DICT (read-lines "/usr/share/dict/words"))

					; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
   (member? "rat" w) (member? "art" w) (member? "tar" w)))

; String -> List-of-strings
; finds all words that the letters of some given word spell

;; (check-member-of (alternative-words "cat")
;;                  (list "act" "cat")
;;                  (list "cat" "act"))

;; (check-satisfied (alternative-words "rat")
;;                  all-words-from-rat?)

(define (alternative-words s)
  (in-dictionary
   (words->strings (arrangements (string->word s)))))

(define (post-of-index word-as-list index)
  (substring (implode word-as-list) 0 index))

(check-expect (post-of-index (list "a" "b" "c") 0) "")
(check-expect (post-of-index (list "a" "b" "c") 1) "a")
(check-expect (post-of-index (list "a" "b" "c") 2) "ab")

(define (pre-of-index word-as-list index)
  (substring (implode word-as-list) index))

(check-expect (pre-of-index (list "a" "b" "c") 0) "abc")
(check-expect (pre-of-index (list "a" "b" "c") 1) "bc")
(check-expect (pre-of-index (list "a" "b" "c") 2) "c")

(define (insert-at-index ch word-as-list index)
  (explode (string-append
            (post-of-index word-as-list index) ch (pre-of-index word-as-list index))))

(check-expect (insert-at-index "x" (list "a" "b" "c") 1) (list "a" "x" "b" "c"))

(define (insert-char-at-index ch word-as-list index)
  (if (empty? word-as-list) (cons ch word-as-list)
      (insert-at-index ch word-as-list index)
      ))

(check-expect (insert-char-at-index "x" (list "a" "b" "c") 1) (list "a" "x" "b" "c"))
(check-expect (insert-char-at-index "x" (list "a" "b" "c") 2) (list "a" "b" "x" "c"))

(define (insert-everywhere index ch word-as-list)
  (if (> index (length word-as-list)) (list)
      (cons (insert-char-at-index ch word-as-list index)
            (insert-everywhere (add1 index) ch word-as-list))
      ))

(check-expect (insert-everywhere 0 "a" '()) (list (list "a")))

(check-expect (insert-everywhere 0 "a" (list "b"))
              (list
               (list "a" "b")
               (list "b" "a")))
(check-expect (insert-everywhere 0 "a" (list "b" "c"))
              (list (list "a" "b" "c")
                    (list "b" "a" "c")
                    (list "b" "c" "a")))

(define (insert-everywhere/in-all-words ch low)
  (if (empty? low) (list)
      (append (insert-everywhere 0 ch (first low))
              (insert-everywhere/in-all-words ch (rest low)))))

(check-expect (insert-everywhere/in-all-words "a" (list '())) (list (list "a")))
(check-expect (insert-everywhere/in-all-words "c" (list (list "a" "t") (list "t" "a")))
              (list
               (list "c" "a" "t")
               (list "a" "c" "t")
               (list "a" "t" "c")
               (list "c" "t" "a")
               (list "t" "c" "a")
               (list "t" "a" "c")))

; Word -> List-of-words
; finds all rearrangements of word
(define (arrangements word)
  (cond
    [(empty? word) (list '())]
    [else (insert-everywhere/in-all-words (first word)
                                          (arrangements (rest word)))]
    ))

; String -> Word
; converts s to the chosen word representation 
(define (string->word s)
  (explode s))

(check-expect (string->word "hello world") (list "h" "e" "l" "l" "o" " " "w" "o" "r" "l" "d"))

; Word -> String
; converts w to a string
(define (word->string w)
  (implode w))

(check-expect (word->string (list "h" "e" "l" "l" "o" " " "w" "o" "r" "l" "d")) "hello world")

;; (in-dictionary
;;  (words->strings
;;   (arrangements (string->word s))))

; List-of-words -> List-of-strings
; turns all Words in low into Strings 
(define (words->strings low)
  (if (empty? low)
      (list)
      (cons (word->string (first low)) (words->strings (rest low)))
      ))

(check-expect (words->strings (list (list "h" "e" "l" "l" "o") (list "w" "o" "r" "l" "d")))
              (list "hello" "world"))


; String List-of-strings -> Boolean
(define (word-in-dict w los)
  (if (empty? los) #false
      (if (string=? w (first los))
          #true
          (word-in-dict w (rest los))
          )))

(check-expect (word-in-dict "zoom" DICT) #true)
(check-expect (word-in-dict "zoooooom" DICT) #false)

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary 
(define (in-dictionary los)
  (if (empty? los) (list)
      (if (word-in-dict (first los) DICT)
          (cons (first los) (in-dictionary (rest los)))
          (in-dictionary (rest los))
          )
      ))

(check-expect (in-dictionary (list "zoom" "zoooooom")) (list "zoom"))

;; version that use the member function
(define (in-dictionary_v2 los)
  (if (empty? los) (list)
      (if (member (first los) DICT)
          (cons (first los) (in-dictionary_v2 (rest los)))
          (in-dictionary_v2 (rest los))
          )
      ))

(check-expect (in-dictionary_v2 (list "zoom" "zoooooom")) (list "zoom"))

;; A Word is one of:
;; – '() or
;; – (cons 1String Word)
;; interpretation a Word is a list of 1Strings (letters)

(define word1 (list "h" "e" "l" "l" "o"))
(define word2 (list "w" "o" "r" "l" "d"))

;; A List-of-words is one of:
;; - '()
;; - (Word List-of-words)

(define low1 (list word1 word2))

(define (is-rat-perm? w)
  (member w (list
             (list "r" "a" "t")
             (list "a" "r" "t")
             (list "t" "a" "r"))))

;; (check-satisfied (arrangements (list "r" "a" "t")) is-rat-perm?)




