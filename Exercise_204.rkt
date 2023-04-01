;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/batch-io)
(require 2htdp/itunes)

; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")

; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

(define date1 (create-date 2020 12 01 01 01 01))
(define date2 (create-date 1911 11 11 11 11 11))

(define track1 (create-track "My song" "Joe Doe" "First album" 60 6 date1 666 date2))
(define track2 (create-track "Sing along" "Jane Doe" "Rythems" 90 12 date2 123 date1))

(define (total-time lot)
  (if (empty? lot) 0
      (+ (track-time (first lot))
         (total-time (rest lot)))
      ))

(check-expect (total-time (list track1 track2)) 150)
(check-expect (total-time itunes-tracks) 23900585)

(define (select-all-album-titles lot)
  (if (empty? lot) (list)
      (cons (track-album (first lot))
            (select-all-album-titles (rest lot)))
      ))

(check-expect (select-all-album-titles (list track1 track2)) (list "First album" "Rythems"))
(check-expect (select-all-album-titles itunes-tracks)
              (list "Feed The Animals"
                    "Feed The Animals"
                    "Nevermind"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Sixteen Stone"
                    "Born Standing Up: A Comic's Life (Unabridged)"
                    "Tech News Today"
                    "Breaking Bad, Season 1"))

(define (rm-string str los)
  (if (empty? los) (list)
      (if (string=? (first los) str)
          (rm-string str (rest los))
          (cons (first los) (rm-string str (rest los)))
          )
      ))

(check-expect (rm-string "d" (list)) (list))
(check-expect (rm-string "d" (list "d" "d" "d" "d")) (list))
(check-expect (rm-string "c" (list "a" "b" "c" "c" "d")) (list "a" "b" "d"))

(define (create-set los)
  (if (empty? los) (list)
      (cons (first los) (create-set (rm-string (first los) (rest los))))
      ))

(check-expect (create-set (list)) (list))
(check-expect (create-set (list "d" "d" "d" "d")) (list "d"))
(check-expect (create-set (list "a" "b" "c" "c" "d")) (list "a" "b" "c" "d"))
(check-expect (create-set (select-all-album-titles itunes-tracks))
              (list "Feed The Animals"
                    "Nevermind"
                    "Sixteen Stone"
                    "Born Standing Up: A Comic's Life (Unabridged)"
                    "Tech News Today"
                    "Breaking Bad, Season 1"))

(define (select-all-album-titles/unique lot)
  (create-set (select-all-album-titles lot)))

(check-expect (select-all-album-titles/unique (list track1 track2)) (list "First album" "Rythems"))
(check-expect (select-all-album-titles/unique itunes-tracks)
              (list "Feed The Animals"
                    "Nevermind"
                    "Sixteen Stone"
                    "Born Standing Up: A Comic's Life (Unabridged)"
                    "Tech News Today"
                    "Breaking Bad, Season 1"))

(define (select-album album-title lot)
  (if (empty? lot) (list)
      (if (string=? (track-album (first lot)) album-title)
          (cons (track-name (first lot)) (select-album album-title (rest lot)))
          (select-album album-title (rest lot))
          )))

(check-expect (select-album "Feed The Animals" itunes-tracks)
              (list "Play Your Part (Pt. 1)" "Shut The Club Down"))

(define (date-min-to-sec d)
  (* (date-minute d) 60))

(define (date-hour-to-sec d)
  (* (date-hour d) 60 60))

(define (date-day-to-sec d)
  (* (date-day d) 60 60 24))

(define (date-month-to-sec d)
  (* (date-month d) 60 60 24 (/ 365 12)))

(define (date-year-to-sec d)
  (* (date-year d) 60 60 24 365))

(define (date-to-sec d)
  (+
   (date-year-to-sec d)
   (date-month-to-sec d)
   (date-day-to-sec d)
   (date-min-to-sec d)
   (date-second d)
   ))

(define (date>= d1 d2)
  (>= (date-to-sec d1) (date-to-sec d2)))

(check-expect (date>= date1 date2) #true)
(check-expect (date>= date2 date1) #false)

(define (select-album-date album-title d lot)
  (if (empty? lot) (list)
      (if (and (string=? (track-album (first lot)) album-title)
               (date>= (track-played (first lot)) d))
          (cons (track-name (first lot)) (select-album-date album-title d (rest lot)))
          (select-album-date album-title d (rest lot))
          )))

(define date3 (create-date 2011 2 27 21 52 7))

(check-expect (select-album-date "Feed The Animals" date3 itunes-tracks)
              (list "Shut The Club Down"))
(check-expect (select-album-date "Feed The Animals" date2 itunes-tracks)
              (list "Play Your Part (Pt. 1)"
                    "Shut The Club Down"))
(check-expect (select-album-date "Feed The Animals" date1 itunes-tracks) (list))

(check-expect (select-album-date "Sixteen Stone" date2 itunes-tracks)
              (list "Everything Zen"
                    "Swim"
                    "Bomb"
                    "Little Things"
                    "Comedown"
                    "Body"
                    "Machinehead"
                    "Testosterone"
                    "Monkey"
                    "Glycerine"
                    "Alien"
                    "X-Girlfriend"))

(define (print l)
  (if (empty? l) (list) (cons (first l) (print (rest l)))))

;; (print itunes-tracks)

;; (define track1 (create-track "My song" "Joe Doe" "First album" 60 6 date1 666 date2))
;; (define track2 (create-track "Sing along" "Jane Doe" "Rythems" 90 12 date2 123 date1))

(define (rm-album str lot)
  (if (empty? lot) (list)
      (if (string=? (track-album (first lot)) str)
          (rm-album str (rest lot))
          (cons (first lot) (rm-album str (rest lot)))
          )
      ))

(check-expect (rm-album "album" (list)) (list))
(check-expect (rm-album "album" (list track1 track2)) (list track1 track2))
(check-expect (rm-album "First album" (list track1 track2)) (list track2))
(check-expect (rm-album "Rythems" (list track1 track2)) (list track1))


(define (select-albums lot)
  (if (empty? lot) (list)
      (cons
       (list (first (select-all-album-titles/unique lot))
             (select-album (first (select-all-album-titles/unique lot)) lot))
       (select-albums (rm-album (first (select-all-album-titles/unique lot)) (rest lot)))
       )
      )
  )

(check-expect (select-albums itunes-tracks)
              (list (list "Feed The Animals"
                          (list "Play Your Part (Pt. 1)"
                                "Shut The Club Down"))
                    (list "Nevermind"
                          (list "Smells Like Teen Spirit"))
                    (list "Sixteen Stone"
                          (list "Everything Zen"
                                "Swim"
                                "Bomb"
                                "Little Things"
                                "Comedown"
                                "Body"
                                "Machinehead"
                                "Testosterone"
                                "Monkey"
                                "Glycerine"
                                "Alien"
                                "X-Girlfriend"))
                    (list "Born Standing Up: A Comic's Life (Unabridged)"
                          (list "Born Standing Up: A Comic's Life (Unabridged)"))
                    (list "Tech News Today"
                          (list "Tech News Today 186: Who Are Yooodle?"))
                    (list "Breaking Bad, Season 1"
                          (list "A No-Rough-Stuff Type Deal")))
              )
