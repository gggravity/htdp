;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; List-of-names -> Boolean
;; determines whether "Flatt" occures on alon

(check-expect (contains-flatt? (cons "X" (cons "Y" (cons "Z" '() )))) #false)

(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '() )))) #true)

(check-expect (contains-flatt?
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman"
                                                         '() )))))))) #true)

(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(string=? (first alon) "Flatt") #true]
    [else (contains-flatt? (rest alon))]

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
