;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 82. Design the function compare-word. The function consumes two
;; three-letter words (see exercise 78).
;;
;; It produces a word that indicates where the given ones agree and disagree.
;; The function retains the content of the structure fields if the two agree;
;; otherwise it places #false in the field of the resulting word.

;; Hint The exercises mentions two tasks: the comparison of words and the
;; comparison of “letters.”

;; three-letter-word -> 1Strings 1Strings 1Strings
;;
;; requirement: 1Strings "a" through "z" plus #false.
;;
;; interpretation:
;; letter1 -> first letter of the word
;; letter2 -> second letter of the word
;; letter3 -> third letter of the word
(define-struct three-letter-word [l-one l-two l-three])


;; compares letters
;; return the first letter if both letters are eq
;; othervise return #false

(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #false)
(check-expect (compare-letter "b" "a") #false)

(define (compare-letter l1 l2)
  (cond [(string=? l1 l2) l1]
        [else #false]))

;; three-letter-word three-letter-word -> three-letter-word 
;; Compares letters in two three-letter-word structures
;; return the first three-letter-word structure with non eq
;; letters replaced with #false
;; The function don't have any checking of the validity of
;; the three-letter-word structures.

(check-expect (compare-word (make-three-letter-word "a" "b" "c")
                            (make-three-letter-word "a" "b" "d"))
              (make-three-letter-word "a" "b" #false))

(check-expect (compare-word (make-three-letter-word "a" "b" "c")
                            (make-three-letter-word "a" "b" "c"))
              (make-three-letter-word "a" "b" "c"))

(define (compare-word word1 word2)
  (make-three-letter-word
   (compare-letter (three-letter-word-l-one word1) (three-letter-word-l-one word2))
   (compare-letter (three-letter-word-l-two word1) (three-letter-word-l-two word2))
   (compare-letter (three-letter-word-l-three word1) (three-letter-word-l-three word2))))
