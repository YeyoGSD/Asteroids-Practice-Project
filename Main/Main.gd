extends Node

const MENU_SCENE:PackedScene = preload("res://PausedMenu/paused_menu.tscn")

func _unhandled_key_input(event:InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var paused_menu:Control = MENU_SCENE.instantiate()
		add_child(paused_menu)
