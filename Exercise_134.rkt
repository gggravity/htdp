;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; List-of-names -> Boolean
;; determines whether "Flatt" occures on alon

(check-expect (contains? (cons "X" (cons "Y" (cons "Z" '() ))) "Flatt") #false)

(check-expect (contains? (cons "A" (cons "Flatt" (cons "C" '() ))) "Flatt") #true)

(check-expect (contains?
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman"
                                                         '() ))))))) "Flatt") #true)

(define (contains? alon value)
  (cond
    [(empty? alon) #false]
    [(string=? (first alon) value) #true]
    [else (contains? (rest alon) value)]

    ;; it's the same expression.
    ;; the or statement is an short circuit statement.
    ;; if the first statement (string=? (first alon) "Flatt") is true,
    ;; the last statement (contains-flatt? (rest alon) is not run.
    ;; it's the same in the new version of contains-flatt.
    ;; it's a personal preference what version is best.

    
    ;; [(cons? alon)
    ;;  (or (string=? (first alon) "Flatt")
    ;;      (contains-flatt? (rest alon)))]
    ))
