class_name Stats
extends Resource

signal stats_changed

@export var max_health:int
@export var max_speed:float
@export var art: Texture

var health: int : set = set_health
var speed: float : set = set_speed

func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()

func set_speed(value : float) -> void:
	speed = clampf(value, 0, max_speed)
	stats_changed.emit()

func take_damage(damage: int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	#damage = clampi(damage, 0, damage)
	self.health -= damage

func heal(amount : int) -> void:
	if amount <= 0:
		return
	self.health += amount

func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.speed = max_speed
	return instance
