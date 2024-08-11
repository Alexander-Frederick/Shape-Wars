extends Control

func _on_back_button_pressed():
	var holder = MenuControl.menuLoads[menu_control.stateMenu.MAIN].instantiate()
	get_parent().add_child(holder)
	queue_free()

