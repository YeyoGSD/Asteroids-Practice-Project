extends Control

@onready var score:Label = $Background/GridContainer/Score

func _ready() -> void:
	get_tree().paused = true
	score.text = score.text + str(Global.score)
	
func _unhandled_key_input(event:InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().paused = false
		get_tree().reload_current_scene()
		queue_free()	
