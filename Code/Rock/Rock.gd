extends ScreenWrapper
class_name Rock

@onready var sprites: AnimatedSprite2D = $Sprites

var main: Main
var velocity: Vector2 = Vector2.ZERO # px / sec.
@export var speed: float = 150

func _ready() -> void:
	# Hookup the collision signals.
	area_entered.connect(on_area_entered)
	
	velocity = Vector2(randf_range(-speed, speed), randf_range(-speed, speed)) 
	# HACK: Not dynamic.
	sprites.frame = randi_range(0, 3)

func _process(delta: float) -> void:
	super._process(delta)
	position += velocity * delta

func split():
	# TODO: Split rocks into to 2 smaller rocks.
	pass

func destroy():
	queue_free()

func on_area_entered(other_area: Area2D):
	print(other_area)
	if other_area is Bullet:
		other_area.ship.player.update_score(3)
		other_area.destroy()
		self.destroy()
	
	elif other_area is Ship:
		other_area.destroy()
		if self != null:
			self.destroy()
