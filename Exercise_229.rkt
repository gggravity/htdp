;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; dimensions of the scene
(define WIDTH 100)
(define HEIGHT 100)

;; side length of the square
(define LEN 50)

;; the background of the scene 
(define BACKGROUND (empty-scene WIDTH HEIGHT "transparent"))

;; the images of the diffence states
(define init-state (overlay
                    (square LEN "outline" "black")
                    (square LEN "solid" "white")))

(define a-state (overlay
                 (square LEN "outline" "black")
                 (square LEN "solid" "yellow")))

(define b-state (overlay
                 (square LEN "outline" "pink")
                 (square LEN "solid" "yellow")))

(define c-state (overlay
                 (square LEN "outline" "green")
                 (square LEN "solid" "yellow")))

(define d-state (overlay
                 (square LEN "outline" "black")
                 (square LEN "solid" "green")))

(define error-state (overlay
                     (square LEN "outline" "black")
                     (square LEN "solid" "red")))

(define render-init-state (place-image/align init-state 25 25 "left" "top" BACKGROUND))
(define render-a-state (place-image/align a-state 25 25 "left" "top" BACKGROUND))
(define render-b-state (place-image/align b-state 25 25 "left" "top" BACKGROUND))
(define render-c-state (place-image/align c-state 25 25 "left" "top" BACKGROUND))
(define render-d-state (place-image/align d-state 25 25 "left" "top" BACKGROUND))
(define render-error-state (place-image/align error-state 25 25 "left" "top" BACKGROUND))

; An FSM is one of:
;   – '()
;   – (cons Transition FSM)

(define-struct transition [current next])
; A Transition is a structure:
;   (make-transition FSM-State FSM-State)

; FSM-State is a Color.

; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes

(define (state=? s1 s2)
  (string=? s1 s2))

(check-expect (state=? "red" "blue") false)
(check-expect (state=? "red" "red") true)

(define bw-machine
  (list (make-transition "black" "white")
        (make-transition "white" "black")))

(define-struct fs [fsm current])
;; A SimulationState is a structure: 
;; (make-fs FSM FSM-State)

(define (find-next-state an-fsm ke)
  (make-fs
   (fs-fsm an-fsm)
   (find (fs-fsm an-fsm) (fs-current an-fsm) ke)
   ))

(define-struct ktransition [current key next])
; A Transition.v2 is a structure:
;   (make-ktransition FSM-State KeyEvent FSM-State)

(define (state-as-colored-square an-fsm)
  (cond
    [(state=? (fs-current an-fsm) "INIT") render-init-state]
    [(state=? (fs-current an-fsm) "A") render-a-state]
    [(state=? (fs-current an-fsm) "B") render-b-state]
    [(state=? (fs-current an-fsm) "C") render-c-state]
    [(state=? (fs-current an-fsm) "D") render-d-state]
    [(state=? (fs-current an-fsm) "ERROR") render-error-state]
    ))

(define (find transitions current key)
  (if (empty? transitions) "ERROR"
      (if (and (key=? key (ktransition-key (first transitions)))
               (state=? (ktransition-current (first transitions)) current)
               )
          (ktransition-next (first transitions))
          (find (rest transitions) current key)
          )))

(define fsm-109
  (list (make-ktransition "INIT" "a" "A")
        (make-ktransition "A" "b" "B")
        (make-ktransition "B" "b" "B")
        (make-ktransition "C" "b" "B")
        (make-ktransition "A" "c" "C")
        (make-ktransition "B" "c" "C")
        (make-ktransition "C" "c" "C")
        (make-ktransition "A" "d" "D")
        (make-ktransition "B" "d" "D")
        (make-ktransition "C" "d" "D")
        (make-ktransition "A" "i" "INIT")
        (make-ktransition "B" "i" "INIT")
        (make-ktransition "C" "i" "INIT")
        (make-ktransition "ERROR" "i" "INIT")
        ))

;; FSM FSM-State -> SimulationState
;; match the keys pressed with the given FSM 
(define (simulate an-fsm s0)
  (big-bang (make-fs an-fsm s0)
            [to-draw state-as-colored-square]
            [on-key find-next-state]))

(simulate fsm-109 "INIT")
