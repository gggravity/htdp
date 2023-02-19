(require 2htdp/batch-io)

(define (letter fst lst signature-name)
  (string-append
   (opening fst)
   "\n\n"
   (body fst lst)
   "\n\n"
   (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))


;; (letter "Matthew" "Fisler" "Felleisen")
;; (letter "Kathi" "Felleisen" "Findler")

;; (write-file 'stdout (letter "Matt" "Fiss" "Fell"))

(define (main in-fst in-lst in-signature out)
  (write-file out
	      (letter (read-file in-fst)
		      (read-file in-lst)
		      (read-file in-signature))))

(main "in-fst.dat" "in-lst.dat" "in-signature.dat" "out.dat")
