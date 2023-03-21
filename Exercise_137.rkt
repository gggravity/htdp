;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(string=? (first alon) "Flatt") #true]
    [else (contains-flatt? (rest alon))]))

(check-expect (contains-flatt? (cons "X" (cons "Y" (cons "Z" '() )))) #false)

(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '() )))) #true)


(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))

(check-expect (how-many '() ) 0)

(check-expect (how-many (cons "A" (cons "B" (cons "C" '() )))) 3)

(check-expect (how-many (cons "A" (cons "B" (cons "C" (cons "D" (cons "E" '() )))))) 5)
