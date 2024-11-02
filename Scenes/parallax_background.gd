extends ParallaxBackground

# Speed of the scroll
var scroll_speed = Vector2(-200, 0)  # Adjust x and y values as needed

func _process(delta):
	# Update the offset of the ParallaxBackground
	self.scroll_offset += scroll_speed * delta
