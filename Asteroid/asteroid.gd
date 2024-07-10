class_name Asteroid
extends Area2D

func _physics_process(delta:float) -> void:
	global_position += Vector2(100, 0).rotated(rotation) * delta

func _on_area_entered(_area:Area2D) -> void:
	queue_free() # Cambiar por fragmentación
