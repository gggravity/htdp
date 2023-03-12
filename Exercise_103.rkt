;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct spider [remaining-legs transport-space])

(define-struct elephant [transport-space])

(define-struct boa-constrictor [length girth transport-space])

(define-struct armadillo [length height weight transport-space])

(define SPIDER (make-spider 4 10))

(define ELEPHANT (make-elephant 100))

(define BOA-CONSTRICTOR (make-boa-constrictor 4 2 20))

(define ARMADILLO (make-armadillo 6 6 6 6))


