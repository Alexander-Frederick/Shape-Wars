extends Node
class_name Load_Out

enum towers {
	PURPLE_SQUARE,
	GREEN_TRIANGLE,
	STAND
}

var towers_data = {
	towers.PURPLE_SQUARE: preload("res://Scenes/Tower Scenes/Purple_Square.tres"),
	towers.GREEN_TRIANGLE: preload("res://Scenes/Tower Scenes/Green_Triangle.tres")
}

var number_of_keys:int = 0
var key_array:Array[Resource] = []
var tower_loadout:Array[PackedScene] = []
var tower_sprite_array:Array[Texture] = []
var tower_draggables:Array[PackedScene] = []

func set_key_array(key:Resource):
	if(not key_array.has(key)):
		key_array.append(key)
		set_sprite_loadout(key.tower_texture)
		set_loadout(key.tower_loadable)
		set_draggables(key.tower_draggable)
		number_of_keys += 1
	return
func erase_key_array(key:Resource):
	key_array.erase(key)
	erase_loadout(key.tower_loadable)
	erase_sprite_loadout(key.tower_texture)
	erase_draggables(key.tower_draggables)
	number_of_keys -= 1

func set_draggables(towerInput:PackedScene):
	tower_draggables.append(towerInput)
func erase_draggables(towerInput:PackedScene):
	tower_draggables.erase(towerInput)

func set_loadout(towerInput:PackedScene):
	tower_loadout.append(towerInput)
func erase_loadout(towerInput:PackedScene):
	tower_loadout.erase(towerInput)

func set_sprite_loadout(towerSprite:Texture):
	tower_sprite_array.append(towerSprite)
func erase_sprite_loadout(towerSprite:Texture):
	tower_sprite_array.erase(towerSprite)

func get_sprite_loadout() -> Array[Texture]:
	return tower_sprite_array
func get_tower_draggables() -> Array[PackedScene]:
	return tower_draggables
func get_tower_loadout() -> Array[PackedScene]:
	return tower_loadout
func get_key(index:int) -> Resource:
	return key_array[index]
