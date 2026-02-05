extends ScreenWrapper
class_name Bullet

var ship: Ship
var speed = 320

func _process(delta: float) -> void:
	super._process(delta)
	var direction = Vector2(sin(rotation), -cos(rotation))
	position += direction * speed * delta
