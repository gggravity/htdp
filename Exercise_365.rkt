;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rkt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

;; '(server ((name "example.org")))

;; <server name="example.org">

;; '(carcas (board (grass)) (player ((name "sam"))))

;; <carcas>
;; <board><grass /></board>
;; <player name="sam" />
;; </carcas> 

;; '(start)

;; <start />