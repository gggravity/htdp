;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(string=? (first alon) "Flatt") #true]
    [else (contains-flatt? (rest alon))]))

(contains-flatt? (cons "Flatt" (cons "C" '())))
