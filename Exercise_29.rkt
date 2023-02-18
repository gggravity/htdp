;; After studying the costs of a show, the owner discovered
;; several ways of lowering the cost. As a result of these improvements, there is no
;; longer a fixed cost; a variable cost of $1.50 per attendee remains.
;; Modify both programs to reflect this change. When the programs are
;; modified, test them again with ticket prices of $3, $4, and $5 and compare the
;; results.

(require 2htdp/batch-io)

(define cost-per-attendee 1.5)
(define alpha 150)
(define beta 120)
(define change-in-price 5.0)


(define (attendees ticket-price)
  (- beta (* (- ticket-price change-in-price) alpha)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* cost-per-attendee (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(for ([i (in-range 3 5 0.1)])
  (write-file 'stdout (string-append (real->decimal-string i)
				     ": "
				     (real->decimal-string (profit i)) "\n")))

;; 3.65
