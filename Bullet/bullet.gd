class_name Bullet
extends Area2D

const SPEED:int = 600
const RANGE:int = 800
var direction:Vector2
var travelled_distance:float = 0

func _physics_process(delta:float) -> void:
	move(delta)
	limit_range(delta)

func move(delta:float) -> void:
	direction = Vector2.RIGHT.rotated(rotation) # Rotación modificada al instanciarse
	global_position += direction * SPEED * delta

func limit_range(delta:float) -> void:
	travelled_distance += SPEED * delta
	if travelled_distance >= RANGE:
		queue_free()

func _on_area_entered(_area:Area2D) -> void:
	queue_free()
