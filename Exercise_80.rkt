;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define-struct movie [title director year])
;; movie -> 

(define (movie-function m)
  (... (movie-title m))
  (... (movie-director m))
  (... (movie-year m)))

(define-struct pet [name number])
;; pet ->
(define (pet-function p)
  (... (pet-name p))
  (... (pet-number p)))

(define-struct CD [artist title price])
;; CD ->
(define (cd-function cd)
  (... (CD-artist cd))
  (... (CD-title cd))
  (... (CD-price cd)))

(define-struct sweater [material size color])
;; sweater ->
(define (sweater-function s)
  (... (sweater-material s))
  (... (sweater-size s))
  (... (sweater-color s)))

