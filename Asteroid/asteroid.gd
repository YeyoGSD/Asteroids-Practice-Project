class_name Asteroid
extends Area2D

signal destroyed

enum SIZE {BIG, MEDIUM, SMALL}

@onready var sprite:Sprite2D = $Sprite
@onready var collision_shape:CollisionShape2D = $CollisionShape

var velocity:Vector2
var extra_velocity:Vector2
var size:SIZE = SIZE.BIG

func _ready() -> void:
	velocity = Vector2(100, 0).rotated(rotation)
	if size != SIZE.BIG:
		set_properties()

func _physics_process(delta:float) -> void:
	global_position += (velocity + extra_velocity) * delta
	extra_velocity = extra_velocity.move_toward(Vector2.ZERO, 5)

func _on_area_entered(_area:Area2D) -> void:
	destroyed.emit(self)
	queue_free()

func _on_visible_on_screen_notifier_screen_exited() -> void:
	queue_free()

func set_properties() -> void:
	match size:
		SIZE.MEDIUM:
			sprite.scale /= 2
			collision_shape.scale /= 2
		SIZE.SMALL:
			sprite.scale /= 4
			collision_shape.scale /= 4
