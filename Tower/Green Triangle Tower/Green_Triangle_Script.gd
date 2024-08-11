class_name Green_Triangle_Tower
extends Tower_Base

func _ready():
	tower_base.add_child(tower_collider)
	tower_range.add_child(tower_range_shape)
	tower_range.position = Vector2(0, -21)
