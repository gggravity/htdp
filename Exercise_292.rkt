;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define (sorted cmp)
  (λ (l)
    #true))

(define (sortet>? l)
  (cond
    [(empty? (rest l)) #true]
    [else
     (and
      (> (first l) (first (rest l)))
      (sortet>? (rest l))
      )]))

;; List-of-numbers -> List-of-numbers
;; produces a sorted version of alon
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else (insert (first alon) (sort> (rest alon)))]
    ))

(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5)) (list 20 12 -5))

(check-satisfied (sort> (list 3 2 1)) sortet>?)
(check-satisfied (sort> (list 1 2 3)) sortet>?)
(check-satisfied (sort> (list 12 20 -5)) sortet>?)

;; Number List-of-number -> List-of-numbers
;; inserts n into the sorted list of numbers alon
(define (insert n alon)
  (cond
    [(empty? alon) (cons n '())]
    [else (if (>= n (first alon))
              (cons n alon)
              (cons (first alon) (insert n (rest alon)))
              )]))

(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5)) (list 20 12 -5))


; [X] [List-of X] [X X -> Boolean] -> [List-of X]
; sorts alon0 according to cmp

(check-expect (sort-cmp '("c" "b") string<?) '("b" "c"))
(check-expect (sort-cmp '(2 1 3 4 6 5) <) '(1 2 3 4 5 6))

(define (sort-cmp alon0 cmp)
  (local (; [List-of X] -> [List-of X]
          ; produces a variant of alon sorted by cmp
          (define (isort l)
            (cond
              [(empty? l) '()]
              [else (insert (first l) (isort (rest l)))]
              ))

          ; X [List-of X] -> [List-of X]
          ; inserts n into the sorted list of numbers alon 
          (define (insert n l)
            (cond
              [(empty? l) (cons n '())]
              [else (if (cmp n (first l))
                        (cons n l)
                        (cons (first l) (insert n (rest l)))
                        )])))
    (isort alon0)))

;; letter-counts List-of-letter-counts -> List-of-letter-counts
;; inserts n into the sorted list of letter-counts l

(check-satisfied (sort-cmp '("c" "b") string<?)
                 (sorted string<?))
(check-satisfied (sort-cmp '(2 1 3 4 6 5) <)
                 (sorted <))

(check-expect [(sorted string<?) '("b" "c")] #true)
(check-expect [(sorted <) '(1 2 3 4 5 6)] #true)


;; [X X -> Boolean] [NEList-of X] -> Boolean 
;; determines whether l is sorted according to cmp

(define (sorted? cmp l)
  (if (empty? (rest l)) #true
      (and
       (cmp (first l) (first (rest l)))
       (sorted? cmp (rest l)))))

(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(2 1 3)) #false)

