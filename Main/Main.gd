extends Node

const MENU_SCENE:PackedScene = preload("res://PausedMenu/paused_menu.tscn")
const GAMEOVER_SCENE:PackedScene = preload("res://GameOver/game_over.tscn")

func _ready() -> void:
	Global.lives = 3
	Global.score = 0

func _unhandled_key_input(event:InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var paused_menu:Control = MENU_SCENE.instantiate()
		add_child(paused_menu)

func _on_level_game_over():
	add_child(GAMEOVER_SCENE.instantiate())
