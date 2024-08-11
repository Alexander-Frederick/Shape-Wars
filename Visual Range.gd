extends Node2D
class_name VisualRange

@export var current_color: Color

var green_color: Color = Color(.25, .56, .38, .62)
var red_color: Color = Color(.76, .23, .27, .62)
# Called when the node enters the scene tree for the first time.
func _ready():
	current_color = green_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	draw_circle(position, 80, current_color)

func change_Color():
	if current_color == green_color:
		current_color = red_color
	elif current_color == red_color:
		current_color = green_color
	
func get_current_color() -> Color:
	return current_color
