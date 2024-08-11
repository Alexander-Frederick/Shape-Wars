extends Control


func _on_play_pressed():
	var levelScreen = MenuControl.menuLoads[menu_control.stateMenu.LEVEL].instantiate()
	add_sibling(levelScreen)
	queue_free()


func _on_options_pressed():
	var options = MenuControl.menuLoads[menu_control.stateMenu.OPTIONS].instantiate()
	add_sibling(options)
	queue_free()


func _on_quit_pressed():
	get_tree().quit()
