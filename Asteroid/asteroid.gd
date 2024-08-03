class_name Asteroid
extends Area2D

signal destroyed

enum SIZE {BIG, MEDIUM, SMALL}

@onready var sprite:Sprite2D = $Sprite
@onready var collision_shape:CollisionShape2D = $CollisionShape

const ORIGINAL_SPEED:int = 100

var speed:int
var direction:Vector2
var size:SIZE = SIZE.BIG

func _ready() -> void:
	speed = ORIGINAL_SPEED
	direction = Vector2(1, 0).rotated(rotation)
	if size != SIZE.BIG:
		set_properties()

func _physics_process(delta:float) -> void:
	global_position += speed * direction * delta
	speed = lerp(speed, ORIGINAL_SPEED, 0.1)

func _on_area_entered(_area:Area2D) -> void:
	destroyed.emit(self)
	queue_free()

func _on_visible_on_screen_notifier_screen_exited() -> void:
	queue_free()

func set_properties() -> void:
	speed += 200
	match size:
		SIZE.MEDIUM:
			sprite.scale /= 2
			collision_shape.scale /= 2
		SIZE.SMALL:
			sprite.scale /= 4
			collision_shape.scale /= 4
