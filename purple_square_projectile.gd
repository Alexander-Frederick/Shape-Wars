
extends Area2D


@onready var sprite_2d = $Sprite2D

@export var speed:float = 20
@export var damage:int = 15
@export var art:Texture
@export var lerpSpeed:float = .0

var velocity = Vector2.ZERO

func _ready():
	sprite_2d.texture = art

func _physics_process(delta):
	position += velocity * delta

func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		if area.has_method("take_damage"):
			area.take_damage(damage)
			queue_free()

func speed_control(target_position:Vector2, initial_position:Vector2):
	position = initial_position
	velocity = (target_position - initial_position).normalized() * speed
	look_at(target_position)
