class_name  Player
extends CharacterBody2D

signal shot
signal hit

@onready var sprite:Sprite2D = $Sprite
@onready var sprite_size:Vector2 = sprite.texture.get_size() * sprite.get_scale()
@onready var bullet_spawn_marker:Marker2D = $BulletSpawnMarker
@onready var area_collision_shape:CollisionShape2D = $HitArea/AreaCollisionShape
@onready var shooting_timer:Timer = $Timers/ShootingTimer
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var laser_sound_player:AudioStreamPlayer = $LaserSoundPlayer

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
		velocity = velocity.limit_length(MAX_SPEED)
	else:
		velocity.move_toward(Vector2.ZERO, 3)

func screen_wrap() -> void:
	global_position.x = wrapf(global_position.x, - sprite_size.x, Global.viewport_size.x + sprite_size.x)
	global_position.y = wrapf(global_position.y, - sprite_size.y, Global.viewport_size.y + sprite_size.y)

func shoot() -> void:
	if can_shoot:
		can_shoot = false
		shooting_timer.start()
		laser_sound_player.play()
		shot.emit()

func _on_shooting_timer_timeout() -> void:
	can_shoot = true

func _on_hit_area_area_entered(_area:Area2D) -> void:
	animation_player.play("hit")
	hit.emit()
