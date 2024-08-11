class_name draggable_base
extends Area2D

@export var tower_stats : Tower : set = set_Tower_Stats

@onready var tower_sprite = $Tower_Sprite
@onready var tower_range = $Range
@onready var tower_drag = $"."
@onready var tower_visual_range: Node2D = tower_stats.towerVisualRangeShape.instantiate()
@onready var tower_collider: Node2D = tower_stats.towerCollision.instantiate()

var allowed_to_place: bool = true
var towers_collided_with: Array[Node2D] = []
var tower_empty: Array[Node2D] = []


func _ready():
	tower_drag.add_child(tower_collider)
	tower_range.add_child(tower_visual_range)

func set_Tower_Stats(value: Tower) -> void:
	tower_stats = value.create_instance()
	
	if not tower_stats.tower_changed.is_connected(update_tower_stats):
		tower_stats.tower_changed.connect(update_tower_stats)
	
	update_tower()

func update_tower() -> void:
	if not tower_stats is Tower:
		return
	if not is_inside_tree():
		await ready
	
	tower_sprite.texture = tower_stats.art
	tower_range.scale = tower_range.scale * (tower_stats.towerRange)
	
	update_tower_stats()

func update_tower_stats() -> void:
	#Used for UI updating
	pass


func _on_area_entered(area):
	towers_collided_with.append(area)
	if(allowed_to_place == true):
		tower_visual_range.change_Color()
		tower_visual_range.queue_redraw()
		allowed_to_place = false


func _on_area_exited(area):
	towers_collided_with.erase(area)
	if(towers_collided_with.hash() == tower_empty.hash()):
		tower_visual_range.change_Color()
		tower_visual_range.queue_redraw()
		allowed_to_place = true

func get_allowability() -> bool:
	return allowed_to_place
