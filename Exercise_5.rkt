;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex063) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)


(define WIDTH 400)
(define HEIGHT 400)

(define MAST (rectangle 15 160 "solid" "light brown"))
(define SAIL (triangle 130 "solid" "tan"))
(define WATER (rectangle WIDTH (/ HEIGHT 2) "solid" "navy"))

(define SHIP (overlay/xy (rectangle  200 30 "solid" "brown")
			 0 10
			 (ellipse 200 40 "solid" "brown")))

(define SAIL_SHIP
  (overlay/xy
   (overlay/xy SHIP 90 -115 MAST)
   33 -10 SAIL))

;; The program

(place-image SAIL_SHIP
	     (/ WIDTH 2)
	     (/ HEIGHT 2)
	     
	     (place-image WATER
			  (/ WIDTH 2)
			  (+ (/ HEIGHT 2) (/ HEIGHT 3))
			  
			  (empty-scene WIDTH HEIGHT "Sky Blue")))



