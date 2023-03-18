;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define-struct cat [x-pos happy])
(define-struct chameleon [x-pos happy color])

;; the main structure, consiste of a cat, a chameleon
;; and the name of the animal that cant use keyevents
;; current-animal is one of
;; CAT
;; CHAMELEON
(define-struct animals [cat chameleon current-animal])

;; dimensions of the scene
(define WIDTH 1000)
(define HEIGHT 400)

;; the speed of the animals
(define cham-speed 10)
(define cat-speed 10)

;; location of the bitmaps
(define cat1 (bitmap "images/cat1.png"))
(define cham-image (bitmap "images/chameleon.png"))

(define (cham1 cham)
  (overlay cham-image (cham-background(chameleon-color cham))))

(define (cham-background color)
  (rectangle (image-width cham-image) (image-height cham-image) "solid" color))

;; define happines
(define (happines animals)
  (above/align "left"
   (rectangle (* 10 (chameleon-happy (animals-chameleon animals))) 20 "solid" "lightred")
   (rectangle (* 10 (cat-happy (animals-cat animals))) 20 "solid" "red")))

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

(define(tock-cham cham)
  (cond
    [(< (chameleon-x-pos cham) WIDTH)
     (make-chameleon
      (+ (chameleon-x-pos cham) cham-speed)
      (cond
        [(> (chameleon-happy cham) 00)
         (- (chameleon-happy cham) 0.5)]
        [else (chameleon-happy cham)]
        )
      (chameleon-color cham))]
    [else (make-chameleon 0 (chameleon-happy cham) (chameleon-color cham))]
    ))

(define(tock-cat cat)
  (cond
    [(< (cat-x-pos cat) WIDTH)
     (make-cat
      (+ (cat-x-pos cat) cat-speed)
      (cond
        [(> (cat-happy cat) 0)
         (- (cat-happy cat) 0.5)]
        [else (cat-happy cat)]
        ))]
    [else  (make-cat 0 (cat-happy cat))]
    ))

(define (tock animals)
  (make-animals
   (tock-cat (animals-cat animals))
   (tock-cham (animals-chameleon animals))
   (animals-current-animal animals)))

(define (render animals)
  (place-image
   (cham1 (animals-chameleon animals)) (chameleon-x-pos (animals-chameleon animals)) (* HEIGHT 0.35)
   (place-image cat1 (cat-x-pos (animals-cat animals)) (* HEIGHT 0.8)
                (place-image/align (happines animals) 0 0 "left" "top" BACKGROUND))))

(define (feed animals)
  (cond
    [(eq? (animals-current-animal animals) "CAT")
     (cond
       [(>=  (cat-happy (animals-cat animals)) 100) animals]
       [else
        (make-animals
         (make-cat
          (cat-x-pos (animals-cat animals))
          (+ (cat-happy (animals-cat animals)) 25))
         (animals-chameleon animals)
         (animals-current-animal animals))])]
    [else
     (cond
       [(>= (chameleon-happy (animals-chameleon animals)) 100) animals]
       [else
        (make-animals
         (animals-cat animals)
         (make-chameleon
          (chameleon-x-pos (animals-chameleon animals))
          (+ (chameleon-happy (animals-chameleon animals)) 25)
          (chameleon-color (animals-chameleon animals)))
         (animals-current-animal animals)
         )])]
    ))

(define (red animals)
  (cond
    [(eq? (animals-current-animal animals) "CHAMELEON")
     (make-animals
      (animals-cat animals)
      (make-chameleon (chameleon-x-pos (animals-chameleon animals))
                      (chameleon-happy (animals-chameleon animals))
                      "red")
      (animals-current-animal animals))]
    [else animals]))

(define (green animals)
  (cond
    [(eq? (animals-current-animal animals) "CHAMELEON")
     (make-animals
      (animals-cat animals)
      (make-chameleon (chameleon-x-pos (animals-chameleon animals))
                      (chameleon-happy (animals-chameleon animals))
                      "green")
      (animals-current-animal animals))]
    [else animals]))

(define (blue animals)
  (cond
    [(eq? (animals-current-animal animals) "CHAMELEON")
     (make-animals
      (animals-cat animals)
      (make-chameleon (chameleon-x-pos (animals-chameleon animals))
                      (chameleon-happy (animals-chameleon animals))
                      "blue")
      (animals-current-animal animals))]
    [else animals]))

(define (pet animals)
   (cond
     [(> (cat-happy (animals-cat animals)) 100) animals]
     [else 
       (make-animals
        (make-cat (cat-x-pos (animals-cat animals)) (+ (cat-happy (animals-cat animals)) 10))
        (animals-chameleon animals)
        (animals-current-animal animals))]))

(define (toggle animals)
  (cond
    [(eq? (animals-current-animal animals) "CAT")
     (make-animals (animals-cat animals) (animals-chameleon animals) "CHAMELEON")]
    [(eq? (animals-current-animal animals) "CHAMELEON")
     (make-animals (animals-cat animals) (animals-chameleon animals) "CAT")]
    ))

(define (attention animals ke)
  (cond
    [(and (eq? (animals-current-animal animals) "CAT") (key=? ke "up")) (pet animals)]
    [(key=? ke "down") (feed animals)]
    [(key=? ke "r") (red animals)]
    [(key=? ke "g") (green animals)]
    [(key=? ke "b") (blue animals)]
    [(key=? ke "t") (toggle animals)]
    [else animals]))

(define (cham-and-cat animals)
  (big-bang animals
	    [on-tick tock]
	    [to-draw render]
	    [on-key attention]
            ))

(define CAT (make-cat 50 100))
(define CHAMELEON (make-chameleon 0 100 "green"))

(define ANIMALS (make-animals CAT CHAMELEON "CHAMELEON"))

;; (cham-and-cat CAT)
;; (cham-and-cat CHAMELEON)
(cham-and-cat ANIMALS)
