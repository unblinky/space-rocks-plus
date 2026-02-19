extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")

var spawn_count: int = 4
var rocks: Array[Rock]

func _ready() -> void:
	spawn_rocks(spawn_count)

func spawn_rocks(count: int):
	for i in count:
		var rock = ROCK.instantiate()
		add_child(rock)
		rocks.append(rock)
	
	print("Rocks: ", rocks)

func is_game_over() -> bool:
	if rocks.is_empty():
		return true
	return false
