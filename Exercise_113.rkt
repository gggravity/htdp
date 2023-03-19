;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; a UFO is a Posn
;; interpretation (make-posn x y) is the UFO's location
;; (using the top-down, left-to-right convention)


;; a Tank is a structure:
;;    (make-tank x dx) specifies the position:
;; (x, HEIGHT) and the tank's speed: dx pixels/tick.
(define-struct tank [loc vel])

;; the state when no missiles have in the scene.
(define-struct aim [ufo tank])

;; the state after a missile have been fired.
(define-struct fired[ufo tank missile])

;; a SIGS (space invader game scene) is one of:
;; --- (make-aim UFO Tank)
;; --- (make-fired UFO Tank Missile)
;; interpretation: represents the complete state of a
;; space invader game.
(define (sigs-or-not? a)
  (cond
    [(aim? a) #true]
    [(fired? a) #true]
    [else #false]))

(define UFO (make-posn 10 10))

(check-expect (sigs-or-not? (make-aim UFO (make-tank 1 1))) #true)
(check-expect (sigs-or-not? (make-fired UFO (make-tank 1 1) (make-posn 9 2))) #true)
(check-expect (sigs-or-not? (make-posn 9 2)) #false)
(check-expect (sigs-or-not? "yellow") #false)



;; A Coordinate is one of: 
;; – a NegativeNumber 
;; interpretation on the y axis, distance from top
;; – a PositiveNumber 
;; interpretation on the x axis, distance from left
;; – a Posn
;; interpretation an ordinary Cartesian point

(define (coordinate-or-not? a)
  (cond
    [(number? a)
     (cond
       [(= a 0) #false]
       [else #true])]
    [(posn? a) #true]
    [else #false]))

(check-expect (coordinate-or-not? 1) #true)
(check-expect (coordinate-or-not? 2) #true)
(check-expect (coordinate-or-not? (make-posn 1 2)) #true)
(check-expect (coordinate-or-not? "1") #false)
(check-expect (coordinate-or-not? "hello world") #false)
(check-expect (coordinate-or-not? 0) #false)


(define-struct cat [x-pos happy])
(define-struct chameleon [x-pos happy color])

;; A VAnimal is either
;; -- a cat
;; -- a chameleon

(define (animal-or-not? a)
  (cond
    [(cat? a) #true]
    [(chameleon? a) #true]
    [else #false]))


(check-expect (animal-or-not? 0) #false)
(check-expect (animal-or-not? 1) #false)
(check-expect (animal-or-not? (make-cat 0 100)) #true)
(check-expect (animal-or-not? (make-chameleon 0 100 "blue")) #true)
(check-expect (animal-or-not? "hello world") #false)
