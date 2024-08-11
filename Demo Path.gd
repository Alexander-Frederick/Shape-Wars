extends Path2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.curve.get_baked_length())
