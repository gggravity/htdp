;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define (string-first str)
  ;; String
  ;; return the first character in a string
  ;; given:
  ;;    "Hello world"
  ;; expected:
  ;;    "H"
  (substring str 0 1))

(define (string-rest str)
  ;; String
  ;; return the provided string with the first character removed.
  ;; given:
  ;;    "Hello world"
  ;; expected:
  ;;    "ello world"
  (substring str 1))


(define (string-last str)
  ;; String
  ;; return the last character in a string
  ;; given:
  ;;    "Hello world"
  ;; expected:
  ;;    "d"
  (substring str (- (string-length str) 1)))

(define (string-remove-last str)
  ;; String
  ;; produces a string like the given one with the last character removed.
  ;; given:
  ;;    "Hello world"
  ;; expected:
  ;;    "Hello worl"
  (substring str 0 (- (string-length str) 1)))

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

(define (move-left ed)
  (cond
    [(> (string-length (editor-pre ed)) 0)
     (make-editor
      (string-remove-last (editor-pre ed))
      (string-append (string-last (editor-pre ed)) (editor-post ed)))]
    [else ed]))

(define (move-right ed)
  (cond
    [(> (string-length (editor-post ed)) 0)
     (make-editor
      (string-append (editor-pre ed)(string-first (editor-post ed)))
      (string-rest (editor-post ed)))]
    [else ed]))

(define (delete-char ed)
  (cond
    [(> (string-length (editor-pre ed)) 0)
     (make-editor
      (string-remove-last (editor-pre ed))
      (editor-post ed))]
    [else ed]))

(define (edit ed ke)
  (cond [(key=? ke "left") (move-left ed)]
        [(key=? ke "right") (move-right ed)]
        [(key=? ke "\b") (delete-char ed)]
        [(key=? ke "\t") ed]
        [(key=? ke "\r") ed]
        [else ed]))

(define (run ed)
  (big-bang ed
            [to-draw render]
            [on-key edit]
            ))

(define ed (make-editor "hello " "world"))


(run ed)

;; (move-left ed)



;; (string-remove-last (editor-pre ed))
