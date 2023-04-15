;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

;; How many times does a file name read! occur in the directory tree TS?

;; 2

;; Can you describe the path from the root directory to the occurrences?

;; . -> read!

;; . -> Libs -> Docs-> read!

;; What is the total size of all the files in the tree?

(check-expect (+ 8 2 19 99 52 17 10) 207)

;; What is the total size of the directory if each directory node has size 1?

(check-expect (+ 207 (* 5 1)) 212)

;; How many levels of directories does it contain? 

;; 5 total, 3 deep
