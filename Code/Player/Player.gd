extends PanelContainer
class_name Player

const SHIP = preload("res://Ship/Ship.tscn")
const LIFE = preload("res://Player/assets/life.tscn")

@onready var score_ui: Label = $VBox/ScoreUI
@onready var lives_ui: HBoxContainer = $VBox/LivesUI

var ship: Ship = null
var score: int = 0 # TODO: Load Hi Score from save file.
var lives: int = 5

func _ready() -> void:
	update_lives(0)
	update_score(0)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("launch_ship"):
		launch_ship()

func launch_ship():
	if ship == null:
		update_lives(-1)
		ship = SHIP.instantiate()
		ship.player = self
		ship.position = get_viewport().size * 0.5
		add_child(ship)
		

# TODO: Test later.
func update_score(delta_score):
	score += delta_score
	score_ui.text = str(score)

func update_lives(delta_lives):
	lives += delta_lives
	print("Lives: ", lives)
	
	# Wipe lives.
	for life in lives_ui.get_children():
		life.queue_free()
	
	# Ruibuild lives row.
	for i in lives:
		var life = LIFE.instantiate()
		lives_ui.add_child(life)
