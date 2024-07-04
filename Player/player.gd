class_name  Player
extends CharacterBody2D

signal shot

@onready var shooting_timer:Timer = $ShootingTimer

const ACCELERATION:int = 10
const MAX_SPEED:int = 300
var direction:Vector2
var can_shoot:bool = true

func _physics_process(_delta:float) -> void:
	input_movement()
	look_at(get_viewport().get_mouse_position())
	move_and_slide()

func _unhandled_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		shoot()

func input_movement() -> void:
	direction = Input.get_vector("move_left","move_right", "move_up", "move_down")
	
	if direction:
		velocity += direction * ACCELERATION
		velocity.limit_length(MAX_SPEED)
	else:
		velocity.move_toward(Vector2.ZERO, 3)

func shoot() -> void:
	if can_shoot:
		can_shoot = false
		shooting_timer.start()
		shot.emit()

func _on_shooting_timer_timeout() -> void:
	can_shoot = true
