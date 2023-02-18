;; (require 2htdp/image)
;; (require 2htdp/universe)

;; (circle 10 "solid" "green")

;; (rectangle 10 20 "solid" "blue")

;; (star 12 "solid" "gray")

;; (image-width (circle 10 "solid" "red"))

;; (image-height (rectangle 10 20 "solid" "blue"))

;; (+ (image-width (circle 10 "solid" "red"))
;;    (image-height (rectangle 10 20 "solid" "blue")))

;; (overlay (square 40 "solid" "orange")
;; 	 (circle 60 "solid" "yellow"))

;; (underlay (circle 60 "solid" "yellow")
;; 	 (square 40 "solid" "orange"))

;; (define x 0)
;; (if (= x 0) 0 (/ 1 x))

;; (require 2htdp/batch-io)

;; (define (letter fst lst signature-name)
;;   (string-append
;;    (opening fst)
;;    "\n\n"
;;    (body fst lst)
;;    "\n\n"
;;    (closing signature-name)))

;; (define (opening fst)
;;   (string-append "Dear " fst ","))

;; (define (body fst lst)
;;   (string-append
;;    "We have discovered that all people with the" "\n"
;;    "last name " lst " have won our lottery. So, " "\n"
;;    fst ", " "hurry and pick up your prize."))

;; (define (closing signature-name)
;;   (string-append
;;    "Sincerely,"
;;    "\n\n"
;;    signature-name
;;    "\n"))


;; ;; (letter "Matthew" "Fisler" "Felleisen")
;; ;; (letter "Kathi" "Felleisen" "Findler")

;; (write-file 'stdout (letter "Matt" "Fiss" "Fell"))


(define (attendees ticket-price)
  (- 120 (* (- ticket-price 5.0) (/ 15 0.1))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ 180 (* 0.04 (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
