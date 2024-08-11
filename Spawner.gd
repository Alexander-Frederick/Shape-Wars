extends Sprite2D

@export var spawn_interval_min:float = 2
@export var spawn_interval_max:float = 4
@export var enemies:Array[PackedScene] = []

@export var h_offset_range: float = 1.0 # Adjust as needed
@export var v_offset_range: float = 1.0 # Adjust as needed
@export var parent_path:Node2D

signal enemy_died()

func _ready():
	spawn_enemies()
	
	
func spawn_enemies():
	var enemy_scene = enemies.pick_random()
	var new_enemy = enemy_scene.instantiate()
	
	new_enemy.h_offset = randf_range(-h_offset_range, h_offset_range)
	new_enemy.v_offset = randf_range(-v_offset_range, v_offset_range)
	
	parent_path.add_child(new_enemy)
	
	get_tree().create_timer(randf_range(spawn_interval_min, spawn_interval_max)).timeout.connect(spawn_enemies)
	
func _on_enemy_died():
	enemy_died.emit()
	
