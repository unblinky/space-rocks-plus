extends Node
class_name Main

const PLAYER = preload("res://Player/Player.tscn")
const ROCK = preload("res://Rock/Rock.tscn")
const UFO = preload("res://UFO/UFO.tscn")

@onready var ufo_timer: Timer = $UfoTimer

var rock_count: int = 4
var rocks: Array[Rock]

func _ready() -> void:
	ufo_timer.timeout.connect(spawn_ufo)

func spawn_player():
	var player = PLAYER.instantiate()
	add_child(player)

func spawn_ufo():
	var ufo = UFO.instantiate()
	add_child(ufo)

func spawn_rocks(count: int):
	for i in count:
		var rock = ROCK.instantiate()
		rock.main = self
		add_child(rock)
		rocks.append(rock)
	
	print("Rocks: ", rocks)

func has_no_rocks() -> bool:
	if rocks.is_empty():
		print("Rocks: ", rocks)
		return true
	return false

func trigger_next_level():
	# Set timer to delay rock spawn?
	rock_count += 1
	spawn_rocks(rock_count)
