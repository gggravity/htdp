;; Determine the potential profit for these ticket prices: $1, $2, $3,
;; $4, and $5. Which price maximizes the profit of the movie theater? Determinethe best ticket price to a dime.

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

;; (for ([i (in-range 1 4 0.01)])
;;   (write-file 'stdout (string-append (number->string i) ": " (number->string (profit i)) "\n")))

;; 2.92

(define (profit2 price)
  (- (* (+ 120
	 (* (/ 15 0.1)
	    (- 5.0 price)))
	price)
     (+ 180
	(* 0.04
	   (+ 120
	      (* (/ 15 0.1)
		 (- 5.0 price)))))))

(= (profit 5) (profit2 5))
