;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; (if exp-test exp-tehn exp-else)

(define exp-test (= 1 0))

;; as if statement
(if exp-test
    #true
    #false)

;; as cond statement
(cond [exp-test #true]
      [else #false])
