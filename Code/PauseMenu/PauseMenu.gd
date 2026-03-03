extends PanelContainer
class_name PauseMenu

@onready var play_button: Button = $VBox/PlayButton
@onready var continue_button: Button = $VBox/ContinueButton
@onready var quit_button: Button = $VBox/QuitButton

func _ready() -> void:
	# signal hooks.
	play_button.pressed.connect(on_play_pressed)
	continue_button.pressed.connect(on_continue_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	continue_button.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		self.visible = get_tree().paused

func on_play_pressed():
	get_parent().start_round()
	hide()

func on_continue_pressed():
	get_tree().paused = false
	hide()

func on_quit_pressed():
	get_tree().quit()
