class_name Tower_Base
extends Area2D

@export var tower_stats : Tower : set = set_Tower_Stats
@export var level_node_path:NodePath
@export var projectile_scene:PackedScene
@export var tower_costs : Tower_Costs

@onready var timer = $Timer
@onready var idle = $StateChart/Root/Idle
@onready var attacking = $StateChart/Root/Attacking
@onready var tower_sprite = $Tower_Sprite
@onready var tower_range = $Enemy_Detector
@onready var tower_attack_speed = $Timer.wait_time
@onready var tower_base = $"."
@onready var tower_range_shape = tower_stats.towerRangeShape.instantiate()
@onready var tower_collider = tower_stats.towerCollision.instantiate()

var enemies_in_range:Array[Node2D]
var enemies_path_progress:Array[PathFollow2D]
var tower_damage: int = 0
var tower_pierces: int = 0
var current_enemy:Node2D = null
var current_enemy_targetted:bool = false
var can_attack:bool = true

func _ready():
	tower_base.add_child(tower_collider)
	tower_range.add_child(tower_range_shape)
	
	#connecting lost signals
	if(not tower_range.area_entered.is_connected(_on_enemy_detector_area_entered)):
		tower_range.area_entered.connect(_on_enemy_detector_area_entered)
	if(not tower_range.area_exited.is_connected(_on_enemy_detector_area_exited)):
		tower_range.area_exited.connect(_on_enemy_detector_area_exited)
	if(not idle.state_processing.is_connected(_on_idle_state_processing)):
		idle.state_processing.connect(_on_idle_state_processing)
	if(not attacking.state_processing.is_connected(_on_attacking_state_processing)):
		attacking.state_processing.connect(_on_attacking_state_processing)
	if(not timer.timeout.is_connected(_on_timer_timeout)):
		timer.timeout.connect(_on_timer_timeout)

func set_Tower_Stats(value: Tower) -> void:
	tower_stats = value.create_instance()
	
	if not tower_stats.tower_changed.is_connected(update_tower_stats):
		tower_stats.tower_changed.connect(update_tower_stats)
	
	update_tower()

func update_tower_stats() -> void:
	#Used for UI updating
	pass

func update_tower() -> void:
	if not tower_stats is Tower:
		return
	if not is_inside_tree():
		await ready
	
	tower_pierces = tower_stats.totalPierces
	tower_damage = tower_stats.towerDamage
	tower_sprite.texture = tower_stats.art
	tower_attack_speed = 1 / tower_stats.attack_speed
	tower_range.scale = tower_range.scale * (tower_stats.towerRange)
	timer.wait_time = tower_attack_speed
	update_tower_stats()

func _on_enemy_detector_area_entered(area):
	enemies_in_range.append(area)
	enemies_path_progress.append(area.get_parent())
	if(enemies_in_range.size() > 0):
		$StateChart.send_event("Enemies_Inside")

func _on_enemy_detector_area_exited(area):
	enemies_in_range.erase(area)
	enemies_path_progress.erase(area.get_parent())
	if(enemies_in_range.size() == 0):
		$StateChart.send_event("No_Enemies")

func _on_idle_state_processing(delta):
	#$Timer.stop()
	can_attack = true

func _on_attacking_state_processing(delta):
	current_enemy = enemies_in_range[get_farest_along_path()]
	if(can_attack == true):
		can_attack = false
		timer.start()

func _on_timer_timeout():
	if(is_instance_valid(current_enemy)):
		var new_projectile = projectile_scene.instantiate()
		new_projectile.set_projectile_stats(0, tower_damage, tower_pierces, 0)
		new_projectile.speed_control(current_enemy.global_position, get_position())
		add_sibling(new_projectile)

func set_level_node_path(path: NodePath) -> void:
	level_node_path = path

func get_farest_along_path() -> int:
	var max_progress: float = 0.0
	var farest: int = 0
	var current_index: int = 0
	for i in enemies_path_progress:
		if i.get_progress_ratio() > max_progress:
			max_progress = i.get_progress_ratio()
			farest = current_index
		current_index += 1
	return farest
