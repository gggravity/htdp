;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; A VAnimal is either
;; -- a cat
;; -- a chameleon

(define-struct cat [x-pos happy])
(define-struct chameleon [x-pos happy color])

;; dimensions of the scene
(define WIDTH 1000)
(define HEIGHT 400)

;; the speed of the animals
(define cham-speed 5)
(define cat-speed 5)

;; location of the bitmaps
(define cat1 (bitmap "images/cat1.png"))
(define cham-image (bitmap "images/chameleon.png"))

(define (cham-background color)
  (rectangle (image-width cham-image)
             (image-height cham-image)
             "solid"
             color))

;; define happines
(define (happines animal)
  (cond
    [(cat? animal)
     (rectangle (* 10 (cat-happy animal)) (/ HEIGHT 2) "solid" "red")]
    [(chameleon? animal)
     (rectangle (* 10 ( chameleon-happy animal)) (/ HEIGHT 2) "solid" "red")]
    ))

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

(define(tock-cham cham)
  (cond
    [(and (> (chameleon-happy cham) 0) (< (chameleon-x-pos cham) WIDTH))
     (make-chameleon
      (+ (chameleon-x-pos cham) cham-speed)
      (- (chameleon-happy cham) 0.5)
      (chameleon-color cham))]
    [else
     (make-chameleon
      0
      (- (chameleon-happy cham) 0.5)
      (chameleon-color cham))]
    ))

(define(tock-cat cat)
  (cond
     [(and (> (cat-happy cat) 0) (< (cat-x-pos cat) WIDTH))
     (make-cat
      (+ (cat-x-pos cat) cat-speed)
      (- (cat-happy cat) 0.5))]
     [else
     (make-cat
      0
      (- (cat-happy cat) 0.5))]
     ))

(define (tock animal)
(cond
  [(cat? animal) (tock-cat animal)]
  [(chameleon? animal) (tock-cham animal)]
  ))

(define (render animal)
  (cond
    [(cat? animal)
     (place-image cat1 (cat-x-pos animal) (* HEIGHT 0.75)
                  (place-image/align (happines animal) 0 0 "left" "top" BACKGROUND))]
    [(chameleon? animal)
     (place-image
      (overlay cham-image (cham-background(chameleon-color animal)))
      (chameleon-x-pos animal) (* HEIGHT 0.75)
      (place-image/align (happines animal) 0 0 "left" "top" BACKGROUND))]
     ))

(define (feed animal)
  (cond
    [(cat? animal)
     (cond
       [(>=  (cat-happy animal) 100) animal]
       [else 
        (make-cat (cat-x-pos animal)
                   (+ (cat-happy animal) 25))])]
    [(chameleon? animal)
     (cond
       [(>=  (chameleon-happy animal) 100) animal]
       [else (make-chameleon (chameleon-x-pos animal)
                             (+ (chameleon-happy animal) 25)
                             (chameleon-color animal))])]
    ))

(define (red animal)
  (cond
    [(chameleon? animal)
     (make-chameleon (chameleon-x-pos animal)
                     (chameleon-happy animal)
                     "red")]
    [else animal]))

(define (green animal)
  (cond
    [(chameleon? animal)
     (make-chameleon (chameleon-x-pos animal)
                     (chameleon-happy animal)
                     "green")]
    [else animal]))

(define (blue animal)
  (cond
    [(chameleon? animal)
     (make-chameleon (chameleon-x-pos animal)
                     (chameleon-happy animal)
                     "blue")]
    [else animal]))

(define (pet animal)
  (cond
    [(chameleon? animal) animal]
    [else
     (cond
       [(>=  (cat-happy animal) 100) animal]
       [else 
        (make-cat
         (cat-x-pos animal)
         (+ (cat-happy animal) 10))])]
    ))

(define (attention animal ke)
  (cond [(key=? ke "up") (pet animal)]
        [(key=? ke "down") (feed animal)]
        [(key=? ke "r") (red animal)]
        [(key=? ke "g") (green animal)]
        [(key=? ke "b") (blue animal)]
        [else animal]))

;; A VAnimal is either
;; -- a cat
;; -- a chameleon

(define (animal-or-not? a)
  (cond
    [(cat? a) #true]
    [(chameleon? a) #true]
    [else #false]))

(define CAT (make-cat 0 100))
(define CHAMELEON (make-chameleon 0 100 "green"))

(check-expect (animal-or-not? CAT) #true)
(check-expect (animal-or-not? CHAMELEON) #true)
(check-expect (animal-or-not? 0) #false)
(check-expect (animal-or-not? 1) #false)
(check-expect (animal-or-not? (make-cat 0 100)) #true)
(check-expect (animal-or-not? (make-chameleon 0 100 "blue")) #true)
(check-expect (animal-or-not? "hello world") #false)

(define (main animal)
  (big-bang animal
	    [on-tick tock]
	    [to-draw render]
	    [on-key attention]))

;; (main CAT)
;; (main CHAMELEON)
