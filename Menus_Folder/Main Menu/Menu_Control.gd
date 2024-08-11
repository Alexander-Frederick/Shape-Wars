class_name menu_control
extends Node

enum stateMenu{
	MAIN,
	OPTIONS,
	LEVEL,
	UPGRADES,
	INFO,
	PAUSE,
	PLAY,
	LOADOUT
}
var menuLoads = {
	stateMenu.MAIN : load("res://Menus_Folder/Menu_Scenes/Main_Menu/main_menu.tscn"),
	stateMenu.OPTIONS : load("res://Menus_Folder/Menu_Scenes/Options/Options Menu.tscn"),
	stateMenu.LEVEL : load("res://Menus_Folder/Menu_Scenes/Level_Selece/level_select.tscn")
	
	
	
}
