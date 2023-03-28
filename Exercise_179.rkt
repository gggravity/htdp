;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 20)
(define WIDTH 200)
(define FONT-SIZE 16)
(define FONT-COLOR "black")

(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

(define-struct editor [pre post])
;; An editor is a structure:
;;   (make-editor Lo1S Lo1S)
;; An Lo1S is one of:
;; -- '()
;; -- (cons 1String Lo1S)

(define good (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all (cons "a" (cons "l" (cons "l" '()))))
(define lla (cons "l" (cons "l" (cons "a" '()))))

;; data example 1:
(make-editor all good)

;; data example 1:
(make-editor lla good)

;; list String -> list
;; add a string to the end of a list
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else (cons (first l) (add-at-end (rest l) s))]
    ))

(check-expect (add-at-end (cons "c" (cons "b" '())) "a")
              (cons "c" (cons "b" (cons "a" '()))))

;; list -> list
;; reverse a list
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end(rev (rest l)) (first l))]
    ))

(check-expect (rev (cons "a" (cons "b" (cons "c" '()))))
              (cons "c" (cons "b" (cons "a" '()))))

;; String String -> Editor
;; creates an editor
(define (create-editor pre post)
  (make-editor (rev (explode pre)) (explode post)))

(check-expect (create-editor "all" "good" ) (make-editor lla good))

;; Editor key -> Editor
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-left ed)]
    [(key=? k "right") (editor-right ed)]
    [(key=? k "\b") ed]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(key=? k "\t") (editor-left ed)]
    [else ed]
    ))

;; insert the 1String k between pre and post
(define (editor-insert ed k)
  (cond
    [(empty? (editor-post ed)) (make-editor (cons k (editor-pre ed)) '())]
    [else  (make-editor (cons k (editor-pre ed)) (editor-post ed))]
    ))

(check-expect (editor-insert (make-editor '() '()) "e")
              (make-editor (cons "e" '()) '()))

(check-expect (editor-insert (make-editor (cons "d" '()) (cons "f" (cons "g" '()))) "e")
              (make-editor (cons "e" (cons "d" '())) (cons "f" (cons "g" '()))))

;; Editor -> Editor
;; move he cursor position one 1String left, if possible
(define (editor-left ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor
           (rest (editor-pre ed))
           (cons (first (editor-pre ed)) (editor-post ed)))]
    ))

(check-expect (editor-left (make-editor '() '()))
              (make-editor  '() '()))

(check-expect (editor-left (make-editor (cons "e" '()) '()))
              (make-editor  '() (cons "e" '())))

(check-expect (editor-left (make-editor '() (cons "e" '())))
              (make-editor '() (cons "e" '())))

(check-expect (editor-left (make-editor (cons "b" (cons "a"'())) (cons "c" (cons "d" '()))))
              (make-editor (cons "a"'()) (cons "b"  (cons "c" (cons "d" '())))))

;; Editor -> Editor
;; move he cursor position one 1String right, if possible
(define (editor-right ed)
  (cond
    [(empty? (editor-post ed)) ed]
    [else (make-editor (cons (first (editor-post ed)) (editor-pre ed))
                       (rest (editor-post ed)))]
    ))

(check-expect (editor-right (make-editor (cons "e" '()) '()))
              (make-editor (cons "e" '()) '()))

(check-expect (editor-right (make-editor '() (cons "e" '())))
              (make-editor (cons "e" '()) '()))

(check-expect (editor-right (make-editor (cons "b" (cons "a"'())) (cons "c" (cons "d" '()))))
              (make-editor (cons "c" (cons "b" (cons "a"'()))) (cons "d" '())))

;; Editor -> Editor
;; delete a 1String to the left of the cursor, if possible
(define (editor-delete ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor (rest (editor-pre ed)) (editor-post ed))]
    ))

(check-expect (editor-delete (make-editor (cons "e" '()) '()))
              (make-editor '() '()))

(check-expect (editor-delete (make-editor '() (cons "e" '())))
              (make-editor '() (cons "e" '())))

(check-expect (editor-delete (make-editor (cons "b" (cons "a"'())) (cons "c" (cons "d" '()))))
              (make-editor (cons "a"'()) (cons "c" (cons "d" '()))))



;; Editor -> Image
;; rander an editor as an image of the two texts
;; separated by the cursor
(define (editor-render ed)
  MT)

(define (main s)
  (big-bang (create-editor s "")
            [to-draw editor-render]
            [on-key editor-kh]
            ))

;; (main "hello")
