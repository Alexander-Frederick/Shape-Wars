class_name Projectile
extends Area2D

@export var projectile_stats : Projectile_Resource = Projectile_Resource.new()
@onready var projectile_area = $"."

var speed:float
var totalPierce: int = projectile_stats.projectile_pierces + 1
var velocity = Vector2.ZERO
var sizeOfProjectile = projectile_stats.projectile_size
var damage: int = 0
var sprite_2d = Sprite2D.new()

func _ready():
	sprite_2d.texture = projectile_stats.projectile_art
	add_child(projectile_stats.projectile_collider.instantiate())
	add_child(sprite_2d)
	if(not projectile_area.area_entered.is_connected(_on_area_entered)):
		projectile_area.area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position += velocity * delta

func set_projectile_stats(tower_speed : int, tower_damage : int, tower_pierce : int, tower_aoe : float):
	speed = projectile_stats.projectile_speed + tower_speed
	totalPierce = tower_pierce + totalPierce
	set_scale(Vector2((tower_aoe + sizeOfProjectile), (tower_aoe + sizeOfProjectile)))
	damage = tower_damage

func _on_area_entered(area):
	if area.has_method("take_damage"):
		totalPierce -= 1
		if(totalPierce >= 0):
			area.take_damage(damage)
		if(totalPierce == 0):
			queue_free()

func speed_control(target_position:Vector2, initial_position:Vector2):
	position = initial_position
	velocity = (target_position - initial_position).normalized() * speed
	var fake_target_position:Vector2 = target_position - position
	fake_target_position = Vector2(-fake_target_position.y, fake_target_position.x)
	fake_target_position += position
	look_at(fake_target_position)
