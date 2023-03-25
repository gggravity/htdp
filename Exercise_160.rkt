;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; List-of-string String -> N
(define (count los s)
  (cond
    [(empty? los) 0]
    [else
     (if (string=? (first los) s)
         (add1 (count (rest los) s))
         (count (rest los) s))
     ]))

(check-expect (count (cons "blue" (cons "hello" (cons "world" (cons "hello" '())))) "hello") 2)
(check-expect (count (cons "blue" (cons "hello" (cons "world" (cons "hello" '())))) "blue") 1)
(check-expect (count (cons "blue" (cons "hello" (cons "world" (cons "hello" '())))) "green") 0)
(check-expect (count (cons "blue" (cons "hello" (cons "world" (cons "hello" '())))) "world") 1)

;; Son
(define es '())

;; Number Son -> Boolean
;; is x in s
(define (in? x s)
  (member? x s))

;; Son -> Boolean
;; #true if 1 a member of s;
(define (not-member-1? s)
  (not (in? 1 s)))

(define (set-.L x s)
  (remove-all x s))

(define (set-.R x s)
  (remove x s))


(define set123-version1
  (cons 1 (cons 2 (cons 3 '()))))

(define set123-version2
  (cons 1 (cons 3 (cons 2 '()))))

(define set23-version1
  (cons 2 (cons 3 '())))

(define set23-version2
  (cons 3 (cons 2 '())))

(check-member-of (set-.L 1 set123-version2)
                 set23-version1
                 set23-version2)

(check-member-of (set-.R 1 set123-version2)
                 set23-version1
                 set23-version2)

(define (set+.L x s)
  (cons x s))


(define (set+.R x s)
  (if (in? x s) s (cons x s)))

(set+.L 1 set123-version1)
(set+.L 11 set123-version1)

(set+.R 1 set123-version1)
(set+.R 11 set123-version1)
