extends ScreenWrapper
class_name Ship

const BULLET = preload("res://Bullet/Bullet.tscn")
@onready var flame: Polygon2D = $Flame

var player: Player

var turn_speed: float = 180.0 # degrees / sec.
var speed: float = 300.0 # Magic unit.
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	flame.hide()

func _process(delta: float) -> void:
	super._process(delta) # Need to ScreenWrap?
	
	if Input.is_action_pressed("turn_ccw"):
		rotation_degrees -= turn_speed * delta
	if Input.is_action_pressed("turn_cw"):
		rotation_degrees += turn_speed * delta
		
	if Input.is_action_pressed("thrust"):
		var direction = Vector2(sin(rotation), -cos(rotation))
		velocity += direction * speed * delta
		flame.show()
		print("Thrust")
		
	if Input.is_action_just_released("thrust"):
		flame.hide()
		
	# Spawn bullet, pos, reparent.
	if Input.is_action_just_pressed("fire"):
		var bullet: Bullet = BULLET.instantiate()
		bullet.ship = self
		bullet.position = self.position
		bullet.rotation = self.rotation
		self.get_parent().add_child(bullet)
		print("fire")

	position += velocity * delta

func destroy():
	player.ship = null
	queue_free()
