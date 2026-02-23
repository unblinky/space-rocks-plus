extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")
const UFO = preload("res://UFO/UFO.tscn")

@onready var ufo_timer: Timer = $UfoTimer

var spawn_count: int = 4
var rocks: Array[Rock]

func _ready() -> void:
	ufo_timer.timeout.connect(spawn_ufo)
	spawn_ufo()
	#spawn_rocks(spawn_count)

func spawn_ufo():
	var ufo = UFO.instantiate()
	add_child(ufo)

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
