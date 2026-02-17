extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")

func _ready() -> void:
	spawn_rocks(4)

func spawn_rocks(count: int):
	for i in count:
		var rock = ROCK.instantiate()
		add_child(rock)
