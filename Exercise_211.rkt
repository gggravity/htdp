;; The first three lines of this file were inserted by DrRacket. They record metadata
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

; A Word is ...

; A List-of-words is ...

; Word -> List-of-words
; finds all rearrangements of word
(define (arrangements word)
  (list word))

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

