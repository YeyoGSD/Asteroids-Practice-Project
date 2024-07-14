extends Node2D

@onready var bullet_scene:PackedScene = preload("res://Bullet/bullet.tscn")
@onready var asteroid_scene:PackedScene = preload("res://Asteroid/asteroid.tscn")
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
	var new_asteroid:Asteroid = asteroid_scene.instantiate()
	new_asteroid.destroyed.connect(_on_asteroid_destroyed)
	new_asteroid.global_position = spawn_point.global_position
	new_asteroid.look_at(player.global_position)
	add_child(new_asteroid)

# No creo que sea la mejor manera de hacerlo pero funciona
func _on_asteroid_destroyed(destroyed_asteroid:Asteroid) -> void:
	if destroyed_asteroid.size == Asteroid.SIZE.SMALL:
		return
	
	for i:int in range(2):
		var new_asteroid:Asteroid = asteroid_scene.instantiate()
		new_asteroid.destroyed.connect(_on_asteroid_destroyed)
		new_asteroid.global_transform = destroyed_asteroid.global_transform
		new_asteroid.rotate(randf_range(-PI/2, PI/2))
		new_asteroid.size += destroyed_asteroid.size + 1
		new_asteroid.extra_velocity = destroyed_asteroid.velocity.normalized() * 200
		call_deferred("add_child", new_asteroid)
