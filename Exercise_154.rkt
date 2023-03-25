;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct layer [color doll])

;; RD -> Number
;; how many dolls are a port of an-rd
(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [else (+ (depth (layer-doll an-rd)) 1)]))

(check-expect (depth "red") 1)
(check-expect (depth (make-layer "yellow" (make-layer "green" "red"))) 3)


;; RD -> Number
;; print the colors of an-rd
(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (string-append
           (layer-color an-rd)
           ", "
           (colors (layer-doll an-rd)))]))

(check-expect (colors "red") "red")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")

