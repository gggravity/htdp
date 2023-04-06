;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/batch-io)

(define DICT (read-lines "/usr/share/dict/words"))

(define (find-words s)
  (local (
          (define (post-of-index word-as-list index)
            (substring (implode word-as-list) 0 index))

          (define (pre-of-index word-as-list index)
            (substring (implode word-as-list) index))

          (define (insert-at-index ch word-as-list index)
            (explode (string-append
                      (post-of-index word-as-list index) ch (pre-of-index word-as-list index))))

          (define (insert-char-at-index ch word-as-list index)
            (if (empty? word-as-list) (cons ch word-as-list)
                (insert-at-index ch word-as-list index)))

          (define (insert-everywhere index ch word-as-list)
            (if (> index (length word-as-list)) (list)
                (cons (insert-char-at-index ch word-as-list index)
                      (insert-everywhere (add1 index) ch word-as-list))))

          (define (insert-everywhere/in-all-words ch low)
            (if (empty? low) (list)
                (append (insert-everywhere 0 ch (first low))
                        (insert-everywhere/in-all-words ch (rest low)))))

          ; Word -> List-of-words
          ; finds all rearrangements of word
          (define (arrangements word)
            (cond
              [(empty? word) (list '())]
              [else (insert-everywhere/in-all-words (first word)
                                                    (arrangements (rest word)))]))

          )
    (arrangements (explode s))
    ))

(find-words "dear")




