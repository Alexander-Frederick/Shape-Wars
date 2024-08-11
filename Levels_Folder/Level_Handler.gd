class_name Level_Handle
extends Node2D

var is_pressed: bool = false
var mouse_position: Vector2 = Vector2.ZERO
var place_position: Vector2 = Vector2.ZERO
var comfirmation_clicks: int = 0

var draggable_location: String
var placeable_location: String
var draggable: Node2D
var placeable: Node2D

func _input(event: InputEvent):
	if is_pressed:
		handle_mouse_button(event)
		handle_mouse_motion(event)



func _process(delta):
	if is_pressed and is_instance_valid(draggable) and comfirmation_clicks == 0:
		draggable.position = mouse_position
	if is_pressed and is_instance_valid(draggable) and comfirmation_clicks == 1:
		#look_at function looks at +X axis, It needs to be corrected to look at -Y axis
		#this operation rotates the mouse position to be on the correct axis
		var fake_mouse_position:Vector2 = mouse_position - draggable.position
		fake_mouse_position = Vector2(-fake_mouse_position.y, fake_mouse_position.x)
		fake_mouse_position += draggable.position
		draggable.look_at(fake_mouse_position)

func _on_background_button_pressed():
	is_pressed = true
	draggable_location = "res://Tower/Square Tower/Purple Draggable.tscn"
	placeable_location = "res://Tower/Square Tower/Purple_Square_Loadable.tscn"
	draggable = load(draggable_location).instantiate()
	placeable = load(placeable_location).instantiate()
	drag_tower()
	#add currency take away somehow

func _on_texture_button_pressed():
	is_pressed = true
	draggable_location = "res://Tower/Green Triangle Tower/Green Triangle Draggable.tscn"
	placeable_location = "res://Tower/Green Triangle Tower/Green_Triangle_Loadable.tscn"
	draggable = load(draggable_location).instantiate()
	placeable = load(placeable_location).instantiate()
	drag_tower()

func drag_tower() -> void:
	if not is_instance_valid(draggable):
		draggable = load(draggable_location).instantiate()
	add_child(draggable)

func place_tower():
	placeable.position = draggable.position
	placeable.rotation = draggable.rotation
	add_child(placeable)
	draggable.queue_free()
	placeable = load(placeable_location).instantiate()

func handle_mouse_button(event: InputEvent):
	if event is InputEventMouseButton and is_instance_valid(draggable) and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			process_left_click()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			process_right_click()

func process_left_click():
	comfirmation_clicks += 1
	if  comfirmation_clicks == 2:
		if draggable.get_allowability():
			place_tower()
			comfirmation_clicks = 0
			is_pressed = false
		else:
			comfirmation_clicks -= 1

func process_right_click():
	if comfirmation_clicks == 2 or comfirmation_clicks == 0:
		draggable.queue_free()
		comfirmation_clicks = 0
	if comfirmation_clicks == 1:
		comfirmation_clicks -= 1

func handle_mouse_motion(event: InputEvent):
	if event is InputEventMouseMotion:
		mouse_position = event.position



