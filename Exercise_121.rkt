;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(+ (* (/ 12 8) 2/3)
   (- 20 (sqrt 4)))

(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/ 1 0) 9)])

(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/ 1 2) 9)])
