extends Resource
class_name Projectile_Resource

@export_group("Projectile Essentials")
@export var projectile_art: Texture
@export var projectile_size: float = 1
@export var projectile_collider: PackedScene
@export var projectile_speed: int = 1
@export_group("Projectile Pierce")
@export var projectile_pierces: int = 0
@export var projectile_can_pierce: bool = true
