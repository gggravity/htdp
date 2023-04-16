;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)
(require htdp/dir)

; String -> Dir.v3
; creates a representation of the a-path directory 
;; (define (create-dir a-path) ...)

(define L (create-dir "/var/log/")) ; on Linux

;; (create-dir "/var/log/")

(define (how-many-text dir)
  (local ((define (append-count d)
            (string-append "Files: " (number->string (length (dir-files d)))))
          (define (walk-dirs dir)
            (for/list ([d (dir-dirs dir)])
              (cons (dir-name d) (cons (append-count d) (walk-dirs d))))))
    (cons (dir-name dir) (cons (append-count dir) (walk-dirs dir)))))

(check-expect (how-many-text L) '("log"
                                  "Files: 55"
                                  ("apt" "Files: 7")
                                  ("cups" "Files: 8")
                                  ("dist-upgrade" "Files: 0")
                                  ("gdm3" "Files: 0")
                                  ("hp" "Files: 0" ("tmp" "Files: 0"))
                                  ("installer" "Files: 9")
                                  ("journal" "Files: 0" ("9d12da9e88ac4fb1897fcfe3b36c9e6c" "Files: 20"))
                                  ("openvpn" "Files: 0")
                                  ("postgresql" "Files: 7")
                                  ("private" "Files: 0")
                                  ("speech-dispatcher" "Files: 0")
                                  ("sysstat" "Files: 31")
                                  ("unattended-upgrades" "Files: 7")))

(define (how-many dir)
  (local ((define (count d)
            (length (dir-files d)))
          (define (walk-dirs dir)
            (for/sum ([d (dir-dirs dir)])
              (+ (count d) (walk-dirs d)))))
    (+ (count dir) (walk-dirs dir))))

(check-expect (how-many L) 144)

