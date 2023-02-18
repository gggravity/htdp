;; Collect all definitions and change them so that all magic numbers are refactored into
;; constant definitions.

(require 2htdp/batch-io)

(define cost-per-attendee 0.04)
(define fixed-cost 180)
(define alpha 150)
(define beta 120)
(define change-in-price 5.0)


(define (attendees ticket-price)
  ;; (- beta (* (- ticket-price 5.0) (/ 15 0.1))))
  (- beta (* (- ticket-price change-in-price) alpha)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ fixed-cost (* cost-per-attendee (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(for ([i (in-range 1 4 0.01)])
  (write-file 'stdout (string-append (number->string i) ": " (number->string (profit i)) "\n")))

;; 2.92
