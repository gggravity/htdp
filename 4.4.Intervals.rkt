(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; ;; A WorldState is a Number.
;; ;; interpretation number of pixels between the top and the UFO

;; (define WIDTH 300) ; distances in terms of pixels 
;; (define HEIGHT 100)
;; (define CLOSE (/ HEIGHT 3))
;; (define MTSCN (empty-scene WIDTH HEIGHT))
;; (define UFO (overlay (circle 10 "solid" "green") (ellipse 40 7 "outline" "green")))

;; ;; WorldState -> WorldState
;; (define (main y0)
;;   (big-bang y0
;;             [on-tick nxt]
;;             [to-draw render/status]))

;; ;; WorldState -> WorldState
;; ;; computes next location of UFO 

;; (check-expect (nxt 11) 12)

;; (define (nxt y)
;;   (+ y 1))

;; ;; WorldState -> Image
;; ;; places UFO at given height into the center of MTSCN

;; (check-expect (render 11) (place-image UFO 12 11 MTSCN))

;; (define (render y)
;;   (place-image UFO (nxt y) y MTSCN))

;; ;; WorldState -> Image
;; ;; adds a status line to the scene created by render  

;; (check-expect (render/status 42)
;;               (place-image (text "closing in" 11 "orange")
;;                            265 90
;;                            (render 42)))

;; (define (render/status y)
;;   (place-image
;;    (cond
;;     [(<= 0 y CLOSE)
;;      (text "descending" 11 "green")]
;;     [(and (< CLOSE y) (<= y HEIGHT))
;;      (text "closing in" 11 "orange")]
;;     [(> y HEIGHT)
;;      (text "landed" 11 "red")])
;;    265 90
;;    (render y)))

;; (main 0)


(define HEIGHT 300) ; distances in pixels
(define WIDTH 100)
(define YDELTA 3)
(define BACKG (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))

(define (p-image x)
  (place-image ROCKET 10 (- x CENTER) BACKG))

(define (p-image-text x)
  (place-image (text (number->string x) 20 "red") 10 (* 3/4 WIDTH) (p-image x)))

(define (show x)
  (cond
   [(string? x) (p-image x)]
   [(<= -3 x -1) (p-image-text x)]
   [(>= x 0) (p-image x)]))

(define (launch x ke)
  (cond
   [(string? x) (if (string=? " " ke) -3 x)]
   [(<= -3 x -1) x]
   [(>= x 0) x]))


;; LRCD -> LRCD
;; raises the rocket by YDELTA if it is moving already 

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly x)
  (cond
   [(string? x) x]
   [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
   [(>= x 0) (- x YDELTA)]))

;; LRCD -> LRCD
(define (main1 s)
  (big-bang s
	    [to-draw show]
	    [on-key launch]))

(main1 0)
