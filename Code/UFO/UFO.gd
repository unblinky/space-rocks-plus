extends Area2D
class_name UFO

const BULLET = preload("res://Bullet/Bullet.tscn")
@onready var up_down_timer: Timer = $UpDownTimer
@onready var shoot_timer: Timer = $ShootTimer

var speed: float = 100.0 # px / sec.
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Signal hooks.
	up_down_timer.timeout.connect(pick_up_down)
	shoot_timer.timeout.connect(on_shoot)
	
	# Pick a screen edge.
	if randi() % 2:
		position.x = 0
		velocity.x = speed
	else:
		position.x = get_viewport().size.x
		velocity.x = -speed
	
	position.y = randi_range(0, get_viewport().size.y)

func on_shoot():
	var bullet = BULLET.instantiate()
	bullet.position = position
	bullet.rotation_degrees = randf_range(0, 360)
	get_parent().add_child(bullet)

func _process(delta: float) -> void:
	position += velocity * delta # Update position.
	
	# Kill UFO if out of bounds.
	if position.x > get_viewport().size.x:
		destroy()
	if position.x < 0:
		destroy()
	
	# Screenwrap vertically.
	if position.y < 0.0:
		position.y = get_viewport().size.y
	if position.y > get_viewport().size.y:
		position.y = 0.0

func destroy():
	queue_free()

## A function that will have the UFO pick up, down, or neither.
func pick_up_down():
	if velocity.y == 0.0:
		if randi() % 2:
			velocity.y = speed
		else:
			velocity.y = -speed
	else:
		velocity.y = 0.0
