extends Node
class_name Main

const PLAYER = preload("res://Player/Player.tscn")
const ROCK = preload("res://Rock/Rock.tscn")
const UFO = preload("res://UFO/UFO.tscn")

@onready var ufo_timer: Timer = $UfoTimer
@onready var pause_menu: PauseMenu = $PauseMenu

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
	
	#print("Rocks: ", rocks)

## Called by the Play Button.
func start_round():
	spawn_rocks(rock_count)
	spawn_player()
	ufo_timer.start()

func remove_rock(rock: Rock):
	rocks.erase(rock)
	rock.destroy()

func check_round_over():
	#print("Rock Number: ", rocks.size())
	if rocks.size() < 1:
		rock_count += 1
		spawn_rocks(rock_count)

func game_over():
	pause_menu.show()
	pause_menu.play_button.show()
	pause_menu.continue_button.hide()
