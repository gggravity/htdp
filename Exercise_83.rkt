;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define height 20)
(define width 200)
(define background (empty-scene width height))

(define-struct editor [pre post])
;; An Editor is a structure:
;;    (make-editor String String)
;; interpretation (make-editor s t) describes an editor
;; whose visible text is (string-append s t) with
;; the cursor displayed between s and t

(define cursor (rectangle 1 20 "solid" "red"))

(define (render-text t)
  (text t 11 "black"))

(define (text-image ed)
  (overlay/align "left" "center"
                 (beside
                  (render-text (editor-pre ed))
                  cursor
                  (render-text (editor-post ed)))
                 background))

(define (render ed)
  (text-image ed))

(define (main ed)
  (big-bang ed
            [to-draw render]
            ))

(main (make-editor "hello " "world"))
