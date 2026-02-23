extends Area2D
class_name UFO

@onready var up_down_timer: Timer = $UpDownTimer

var speed: float = 300.0 # px / sec.
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Signal hooks.
	up_down_timer.timeout.connect(pick_up_down)
	
	# Pick a screen edge.
	if randi() % 2:
		position.x = 0
		velocity.x = speed
	else:
		position.x = get_viewport().size.x
		velocity.x = -speed
	
	position.y = randi_range(0, get_viewport().size.y)


func _process(delta: float) -> void:
	position += velocity * delta
	
	if position.x > get_viewport().size.x:
		destroy()
	if position.x < 0:
		destroy()
	# TODO: Screenwrap vertically.

func destroy():
	queue_free()

func pick_up_down():
	if velocity.y == 0.0:
		if randi() % 2:
			velocity.y = speed
		else:
			velocity.y = -speed
	else:
		velocity.y = 0.0
