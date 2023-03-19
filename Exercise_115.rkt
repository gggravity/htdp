;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define MESSAGE "traffic light expected, given some other value")

;; Any -> Boolean
;; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define (light=? a b)
  (if (and (light? a) (light? b))
      #true
      (if (light? a)
          (error "b not a traffic light")
          (if (light? b)
              (error "a not a traffic light")
              (error MESSAGE)))))

;; (if (and (light? a) (light? b))
;;     (string=? a b)
;;     (error MESSAGE)))


;; (check-expect (light=? "red" "red") #true)
;; (check-expect (light=? "red" "green") #false)
;; (check-expect (light=? "green" "green") #true)
;; (check-expect (light=? "yellow" "yellow") #true)

(light=? "green" "yellow")
