extends Node2D

signal game_over
signal score_changed
signal lives_changed

@onready var player:Player = $Player
@onready var asteroid_spawn_timer:Timer = $AsteroidSpawnTimer
@onready var spawn_point:PathFollow2D = $AsteroidSpawnPath/SpawnPoint

const BULLET_SCENE:PackedScene = preload("res://Bullet/bullet.tscn")
const ASTEROID_SCENE:PackedScene = preload("res://Asteroid/asteroid.tscn")
const EXPLOSION_SCENE:PackedScene = preload("res://ExplosionParticles/explosion.tscn")

func _on_player_shot() -> void:
	var new_bullet:Bullet = BULLET_SCENE.instantiate()
	new_bullet.global_position = player.global_position
	new_bullet.global_rotation = player.rotation
	add_child(new_bullet)

func _on_asteroid_spawn_timer_timeout() -> void:
	spawn_point.progress_ratio = randf()
	var new_asteroid:Asteroid = ASTEROID_SCENE.instantiate()
	new_asteroid.destroyed.connect(_on_asteroid_destroyed)
	new_asteroid.global_position = spawn_point.global_position
	new_asteroid.look_at(player.global_position)
	add_child(new_asteroid)

# No creo que sea la mejor manera de hacerlo pero funciona
func _on_asteroid_destroyed(destroyed_asteroid:Asteroid) -> void:
	Global.score += 10 + (destroyed_asteroid.size * 5)
	score_changed.emit()
	add_explosion(destroyed_asteroid.global_position)
	if destroyed_asteroid.size == Asteroid.SIZE.SMALL:
		return
	
	for i:int in range(2):
		var new_asteroid:Asteroid = ASTEROID_SCENE.instantiate()
		new_asteroid.destroyed.connect(_on_asteroid_destroyed)
		new_asteroid.global_transform = destroyed_asteroid.global_transform
		new_asteroid.rotate(randf_range(-PI/2, PI/2))
		new_asteroid.size += destroyed_asteroid.size + 1
		call_deferred("add_child", new_asteroid)

func add_explosion(spawn_position:Vector2) -> void:
	var new_explosion:CPUParticles2D = EXPLOSION_SCENE.instantiate()
	new_explosion.global_position = spawn_position
	new_explosion.emitting = true
	add_child(new_explosion)

func _on_player_hit() -> void:
	lives_changed.emit()
	if Global.lives <= 0:
		add_explosion(player.global_position)
		player.visible = false
		await get_tree().create_timer(0.6).timeout
		game_over.emit()
