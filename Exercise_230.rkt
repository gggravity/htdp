;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(define-struct fsm [initial transitions final])
(define-struct transition [current key next])

(define fsm-trans
  (list (make-transition "INIT" "a" "A")
        (make-transition "A" "b" "B")
        (make-transition "B" "b" "B")
        (make-transition "C" "b" "B")
        (make-transition "A" "c" "C")
        (make-transition "B" "c" "C")
        (make-transition "C" "c" "C")
        (make-transition "A" "d" "D")
        (make-transition "B" "d" "D")
        (make-transition "C" "d" "D")
        (make-transition "A" "i" "INIT")
        (make-transition "B" "i" "INIT")
        (make-transition "C" "i" "INIT")
        (make-transition "ERROR" "i" "INIT")
        ))

(define (find transitions current key)
  (if (empty? transitions) "ERROR"
      (if (and (string=? key (transition-key (first transitions)))
               (string=? (transition-current (first transitions)) current)
               )
          (transition-next (first transitions))
          (find (rest transitions) current key)
          )))

(check-expect (find fsm-trans "INIT" "d") "ERROR")
(check-expect (find fsm-trans "B" "c") "C")

(define (fsm-simulate initial final transitons trans)
  (if (empty? transitons) (string=? initial final)
      (fsm-simulate
       (find trans initial (first transitons))
       final
       (rest transitons)
       trans)
      ))

(check-expect (fsm-simulate "INIT" "C" (explode "abbbbcc") fsm-trans) #true)
(check-expect (fsm-simulate "INIT" "ERROR" (explode "abbbbcc") fsm-trans) #false)
(check-expect (fsm-simulate "INIT" "D" (explode "abbbbccd") fsm-trans) #true)
(check-expect (fsm-simulate "INIT" "ERROR" (explode "abbtbbccd") fsm-trans) #true)
(check-expect (fsm-simulate "INIT" "ERROR" (explode "abbt") fsm-trans) #true)



1
