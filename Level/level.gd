extends Node2D

@onready var bullet_scene:PackedScene = preload("res://Bullet/bullet.tscn")
@onready var asteroide_scene:PackedScene = preload("res://Asteroid/asteroid.tscn")
@onready var player:Player = $Player
@onready var asteroid_spawn_timer:Timer = $AsteroidSpawnTimer
@onready var spawn_point:PathFollow2D = $AsteroidSpawnPath/SpawnPoint

func _on_player_shot() -> void:
	var new_bullet:Bullet = bullet_scene.instantiate()
	new_bullet.global_position = player.global_position
	new_bullet.global_rotation = player.rotation
	add_child(new_bullet)

func _on_asteroid_spawn_timer_timeout() -> void:
	spawn_point.progress_ratio = randf()
	var new_asteroid:Asteroid = asteroide_scene.instantiate()
	new_asteroid.global_position = spawn_point.global_position
	new_asteroid.look_at(player.global_position)
	add_child(new_asteroid)
