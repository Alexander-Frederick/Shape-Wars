extends draggable_base

var tower_offset: Vector2 = Vector2(0, -21)

func _ready():
	tower_drag.add_child(tower_collider)
	tower_range.add_child(tower_visual_range)
	tower_range.position = tower_offset
