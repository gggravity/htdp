;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define triangle-p (list (make-posn 20 10)
                         (make-posn 20 20)
                         (make-posn 30 20)))

(define square-p (list
                  (make-posn 10 10)
                  (make-posn 20 10)
                  (make-posn 20 20)
                  (make-posn 10 20)))

;; A Polygon is one of:
;; -- list (list Posn Posn Posn)
;; -- (cons Posn Polygon)

; a plain background image
(define MT (empty-scene 50 50))

;; Image Polygon -> Image
;; renders the given polygon p into img
(define (render-poly img p)
  (cond
    [(empty? (rest (rest (rest p))))
     (render-line
      (render-line
       (render-line MT (first p) (second p))
       (second p) (third p))
      (third p) (first p))]
    [else
     (render-line (render-poly img (rest p))
                  (first p)
                  (second p))]))

(check-expect (render-poly MT triangle-p)
              (scene+line
               (scene+line
                (scene+line MT 20 10 20 20 "red")
                20 20 30 20 "red")
               30 20 20 10 "red"))

(check-expect (render-polygon MT square-p)
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))

;; Image Posn Posn -> Image
;; renders a line from p to q into img
(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p) (posn-x q) (posn-y q)
   "red"))

;; An NELoP is one of:
;; -- (cons Posn '())
;; -- (cons Posn NELoP)

;; Image NELop -> Image
;; connects the dots in p by rendering linse in img
(define (connects-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else (render-line
           (connects-dots img (rest p))
           (first p) (second p))]
    ))

(check-expect (connects-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 20 30 20 "red")
               20 10 20 20 "red"))

;; NELoP -> Posn
;; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last (rest p))]))

;; Image Polygon -> Image
;; adds an image of p to img
(define (render-polygon img p)
  (render-line (connects-dots img p)
               (first p)
               (last p)))

(define (render ws)
  ;; (render-poly MT square-p)
  ;; (render-poly MT (rest square-p))
  ;; (render-poly MT (cons (make-posn 40 30) square-p))
  (connects-dots MT triangle-p)
  ;; MT
  )

(define (main ws)
  (big-bang ws
            [to-draw render]
            ))

;; (main 0)
