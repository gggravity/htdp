;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define (string-remove-last str)
  ;; String
  ;; produces a string like the given one with the last character removed.
  ;; given:
  ;;    "Hello world"
  ;; expected:
  ;;    "Hello worl"
  (substring str 0 (- (string-length str) 1)))

(define (string-before ed)
  (substring (editor-str ed) 0 (editor-idx ed)))

(define (string-after ed)
  (substring (editor-str ed) (editor-idx ed)))

(define height 20)
(define width 200)
(define background (empty-scene width height))

(define-struct editor [str idx])
;; An Editor is a structure:
;;    (make-editor String Number)

(define cursor (rectangle 1 20 "solid" "red"))

(define (render-text t)
  (text t 11 "black"))

(define (text-box ed)
  (beside
   (render-text (string-before ed))
   cursor
   (render-text (string-after ed))))

(define (text-image ed)
  (overlay/align "left" "center"
		 (text-box ed)
                 background))

(define (render ed)
  (text-image ed))

(define (move-left ed)
  (cond
    [(> (string-length (string-before ed)) 0)
     (make-editor (editor-str ed) (- (editor-idx ed) 1))]
    [else ed]))

(define (move-right ed)
  (cond
    [(> (string-length (string-after ed)) 0)
     (make-editor (editor-str ed) (+ (editor-idx ed) 1))]
    [else ed]))

(define (delete-char ed)
  (cond
    [(> (string-length (string-before ed)) 0)
     (make-editor
      (string-append (string-remove-last (string-before ed))
                     (string-after ed)) (- (editor-idx ed) 1))]
    [else ed]))

(define (text-to-add ed ke)
  (make-editor
   (string-append (string-before ed) ke (string-after ed)) (+ (editor-idx ed) 1)))

(define (add-char ed ke)
  (cond 
    [(< (image-width (text-box (text-to-add ed ke))) width) (text-to-add ed ke)]
    [else ed]))

(define (edit ed ke)
  (cond [(key=? ke "left") (move-left ed)]
        [(key=? ke "right") (move-right ed)]
        [(key=? ke "\b") (delete-char ed)]
        [(key=? ke "\t") ed]
        [(key=? ke "\r") ed]
        [(= (string-length ke) 1) (add-char ed ke)]
        [else ed]))

(define (run ed)
  (big-bang ed
            [to-draw render]
            [on-key edit]
            ))

(define ed (make-editor "hello world" 6))

(run ed)

;; (string-before ed)
;; (string-after ed)

