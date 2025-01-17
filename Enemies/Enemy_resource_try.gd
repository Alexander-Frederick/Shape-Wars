class_name Enemy
extends Area2D

@export var stats: Stats : set = set_enemy_stats

@onready var enemy_sprite = $Red_Circle_Sprite

func set_enemy_stats(value: Stats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		
	update_enemy()
	

func update_stats() -> void:
	pass

func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
	
	enemy_sprite.texture = stats.art
	update_stats()
	
func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	stats.take_damage(damage)
	
	if stats.health <=0:
		get_parent().queue_free()

