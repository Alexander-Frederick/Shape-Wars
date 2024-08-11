extends Control

func _on_demo_level_pressed():
	var demoLevel: Node2D = load("res://Levels_Folder/Demo_Level.tscn").instantiate()
	add_sibling(demoLevel)
	queue_free()
