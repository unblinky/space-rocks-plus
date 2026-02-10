extends ScreenWrapper
class_name Rock

@onready var sprites: AnimatedSprite2D = $Sprites

var main: Main
var velocity: Vector2 = Vector2.ZERO # px / sec.
@export var speed: float = 150

func _ready() -> void:
	velocity = Vector2(randf_range(-speed, speed), randf_range(-speed, speed)) 
	# HACK: Not dynamic.
	sprites.frame = randi_range(0, 3) 

func _process(delta: float) -> void:
	super._process(delta)
	position += velocity * delta
