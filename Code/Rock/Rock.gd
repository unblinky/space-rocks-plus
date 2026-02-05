extends ScreenWrapper
class_name Rock

var main: Main
var velocity: Vector2 = Vector2.ZERO # px / sec.
@export var speed: float = 150

func _ready() -> void:
	velocity = Vector2(randf_range(-speed, speed), randf_range(-speed, speed)) 

func _process(delta: float) -> void:
	super._process(delta)
	position += velocity * delta

	

	
