extends ScreenWrapper
class_name Rock

const ROCK = preload("res://Rock/Rock.tscn")
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
	if scale.x > 0.25:
		for i in 2:
			var rock: Rock = ROCK.instantiate()
			rock.position = position
			rock.scale = scale * 0.5
			get_parent().add_child(rock)
	
	destroy()

func destroy():
	queue_free()

func on_area_entered(other_area: Area2D):
	print(other_area)
	if other_area is Bullet:
		other_area.player.update_score(1)
		other_area.destroy()
		self.call_deferred("split")
	
	elif other_area is Ship:
		other_area.destroy()
		if self != null:
			self.destroy()
