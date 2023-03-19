;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(check-member-of "green" "red" "yellow" "gray") ; green is not one of red, yellow or gray

(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)
              0.01) ; it's not within the range, 0.1 will work

(check-range #i09 #i0.6 #i0.8) ; 9 not between 6 and 8

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3))) ;; wrong order of 3 and 9

(check-satisfied 4 odd?) ; 4 is not a odd number

