(require 2htdp/image)
(require 2htdp/universe)

(circle 10 "solid" "green")

(rectangle 10 20 "solid" "blue")

(star 12 "solid" "gray")

(image-width (circle 10 "solid" "red"))

(image-height (rectangle 10 20 "solid" "blue"))

(+ (image-width (circle 10 "solid" "red"))
   (image-height (rectangle 10 20 "solid" "blue")))

(overlay (square 40 "solid" "orange")
	 (circle 60 "solid" "yellow"))

(underlay (circle 60 "solid" "yellow")
	 (square 40 "solid" "orange"))
