class_name  Player
extends CharacterBody2D

signal shot

@onready var shooting_timer:Timer = $ShootingTimer
@onready var color_rect:ColorRect = $ColorRect #Temp
@onready var sprite_size:Vector2 = color_rect.get_size() * color_rect.get_scale() #Temp

const ACCELERATION:int = 10
const MAX_SPEED:int = 300
var direction:Vector2
var can_shoot:bool = true

func _physics_process(_delta:float) -> void:
	input_movement()
	screen_wrap()
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

func screen_wrap() -> void:
	global_position.x = wrapf(global_position.x, - sprite_size.x, Global.viewport_size.x + sprite_size.x)
	global_position.y = wrapf(global_position.y, - sprite_size.y, Global.viewport_size.y + sprite_size.y)

func shoot() -> void:
	if can_shoot:
		can_shoot = false
		shooting_timer.start()
		shot.emit()

func _on_shooting_timer_timeout() -> void:
	can_shoot = true
