class_name Tower
extends Resource

signal tower_changed

@export var attack_speed: float = 1.0
@export var towerDamage: int
@export var towerRange: float = 1.0
@export var totalPierces: int = 0
@export var towerCollision: PackedScene
@export var towerRangeShape: PackedScene
@export var towerVisualRangeShape: PackedScene
@export var art: Texture

var current_attack_speed: float : set = set_attack_speed
var current_damage: int : set = set_damage
var current_range: float : set = set_range


func set_attack_speed(value: float) -> void:
	current_attack_speed = clampf(value, 0, 500)
	tower_changed.emit()

func set_damage(value: int) -> void:
	current_damage = value
	tower_changed.emit()

func set_range(value: float) -> void:
	current_range = clampf(value, .5, 700)
	tower_changed.emit()

func create_instance() -> Resource:
	var instance: Tower = self.duplicate()
	instance.current_attack_speed = attack_speed
	instance.current_damage = towerDamage
	instance.current_range = towerRange
	return instance
