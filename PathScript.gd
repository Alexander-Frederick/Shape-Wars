extends PathFollow2D

@onready var enemy = $Enemy

@export var enemy_speed_multiplier: float = 1.0

var enemy_speed: float
func _ready():
	enemy_speed = enemy.stats.max_speed

func _physics_process(delta):
	
	set_progress(get_progress() + (delta * enemy_speed * enemy_speed_multiplier))
