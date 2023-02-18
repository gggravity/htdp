(define (carea length)
  (* length length))


(define (cvolume length)
  (* length (carea length)))


(define (csurface length)
  (* 6 (carea length)))

(cvolume 3)
(csurface 3)

