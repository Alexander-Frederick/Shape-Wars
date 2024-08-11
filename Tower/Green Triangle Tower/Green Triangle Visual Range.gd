extends Polygon2D
class_name Visual_polygon_range

@export var current_color: Color
@onready var green_triangle_visual_range = $"."

var green_color: Color = Color(.25, .56, .38, .62)
var red_color: Color = Color(.76, .23, .27, .62)
# Called when the node enters the scene tree for the first time.
func _ready():
	current_color = green_color
	green_triangle_visual_range.color = current_color

func _process(delta):
	green_triangle_visual_range.color = current_color
	
func change_Color():
	if current_color == green_color:
		current_color = red_color
	elif current_color == red_color:
		current_color = green_color
	
func get_current_color() -> Color:	
	return current_color
