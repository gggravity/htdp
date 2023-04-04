;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; dimensions of the scene
(define HEIGHT 20)
(define WIDTH 10)
(define SIZE 30)

;; the background of the scene 
(define BACKGROUND (empty-scene (* WIDTH SIZE) (* HEIGHT SIZE) "transparent"))

(define BLOCK
  (overlay
   (square (- SIZE 1) "solid" "red")
   (square SIZE "outline" "black")))

(define-struct tetris [block landscape])
(define-struct block [x y])
;; A Tetris is a structure:
;;   (make-tetris Block Landscape)
;; A Landscape is one of: 
;; – '() 
;; – (cons Block Landscape)
;; A Block is a structure:
;;   (make-block N N)

;; interpretations
;; (make-block x y) depicts a block whose left 
;; corner is (* x SIZE) pixels from the left and
;; (* y SIZE) pixels from the top;
;; (make-tetris b0 (list b1 b2 ...)) means b0 is the
;; dropping block, while b1, b2, and ... are resting

(define block-dropping0 (make-block 2 3))
(define block-dropping1 (make-block 2 10))
(define block-landed0 (make-block 0 (- HEIGHT 1)))
(define block-landed1 (make-block 2 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))
(define landscape0 (list block-landed0 block-on-block))
(define landscape1 (list block-landed0 block-landed1 block-on-block))
(define tetris0 (make-tetris block-dropping0 landscape0))
(define tetris1 (make-tetris block-dropping1 landscape1))

;; (define block-generate (make-block (random WIDTH) 0))

(define (block-generate p)
  (block-check-create
   p (make-block (random WIDTH) 0)))

(define (block-check-create p candidate)
  (if (equal? p candidate) (block-generate p) candidate))

(define (landed? t)
  (or (member? (one-below t) (tetris-landscape t))
      (= (block-y (tetris-block t)) (sub1 HEIGHT))
      ))

(define (move-down t)
  (make-tetris (make-block (block-x (tetris-block t)) (add1 (block-y (tetris-block t))))
               (tetris-landscape t)))

(define (one-below t)
  (make-block (block-x (tetris-block t))
              (add1 (block-y (tetris-block t)))
              ))

(define (new-block t)
  (make-tetris (block-generate (make-block -1 0))
               (append (list (tetris-block t)) (tetris-landscape t))))

(define (tock t)
  (if (landed? t)
      (new-block t)
      (move-down t)
      ))

(define (render-block block img)
  (underlay/xy
   img (* (block-x block) SIZE) (sub1 (* (block-y block) SIZE)) BLOCK))

(check-expect (render-block block-dropping0 BACKGROUND)
              (underlay/xy
               BACKGROUND (* (block-x block-dropping0) SIZE)
               (sub1 (* (block-y block-dropping0) SIZE)) BLOCK))

(define (render-landscape l img)
  (if (empty? l) img
      (render-block (first l) (render-landscape (rest l) img))
      ))

(check-expect (render-landscape '() BACKGROUND) BACKGROUND)
(check-expect (render-landscape landscape0 BACKGROUND)
              (render-block block-landed0 (render-block block-on-block BACKGROUND))
              )

(define (tetris-render t)
  (render-block (tetris-block t)
                (render-landscape (tetris-landscape t) BACKGROUND)))

(check-expect (tetris-render tetris0)
              (render-block (tetris-block tetris0)
                            (render-landscape (tetris-landscape tetris0) BACKGROUND)))

(define (move-block-left t)
  (make-block (sub1 (block-x (tetris-block t))) (block-y (tetris-block t)))
  )

(define (move-block-right t)
  (make-block (add1 (block-x (tetris-block t))) (block-y (tetris-block t)))
  )

(define (hit-wall-left? t)
  (= (block-x (tetris-block t)) 0))

(define (hit-wall-right? t)
  (= (block-x (tetris-block t)) (- WIDTH 1)))

(define (hit-landscape-left? t)
  (member? (move-block-left t) (tetris-landscape t)))

(define (hit-landscape-right? t)
  (member? (move-block-right t) (tetris-landscape t)))

(define (move-left t)
  (make-tetris
   (if (and (not (hit-wall-left? t))
            (not (hit-landscape-left? t)))
       (move-block-left t)
       (tetris-block t)
       )
   (tetris-landscape t)
   ))

(define (move-right t)
  (make-tetris
   (if (and (not (hit-wall-right? t))
            (not (hit-landscape-right? t)))
       (move-block-right t)
       (tetris-block t)
       )
   (tetris-landscape t)
   ))

(define (on-key-actions t ke)
  (cond
    [(key=? ke "left") (move-left t)]
    [(key=? ke "right") (move-right t)]
    [else t]))

(define (simple-tetris t rate)
  (big-bang t
            [on-tick tock rate]
            [to-draw tetris-render]
            [on-key on-key-actions]
            ))

(simple-tetris tetris1 0.2)


