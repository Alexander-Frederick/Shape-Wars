extends Sprite2D

@export var speed:int = 20
@export var health:int = 200
@export var currency_dropped:int = 1


signal died()



func take_damage(damage:int):
	health -= damage
	if health <= 0:
		died.emit()
		queue_free()
	
func can_move():
	return speed
