extends Node

const MENU_SCENE:PackedScene = preload("res://PausedMenu/paused_menu.tscn")
const GAMEOVER_SCENE:PackedScene = preload("res://GameOver/game_over.tscn")

@onready var score_canvas:CanvasLayer = $ScoreCanvas
@onready var score:Label = $ScoreCanvas/GridContainer/Score
@onready var lives:Label = $ScoreCanvas/GridContainer/Lives

func _ready() -> void:
	Global.lives = 3
	Global.score = 0

func _unhandled_key_input(event:InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var paused_menu:Control = MENU_SCENE.instantiate()
		add_child(paused_menu)

func _on_level_game_over() -> void:
	score_canvas.visible = false
	add_child(GAMEOVER_SCENE.instantiate())

func _on_level_score_changed() -> void:
	score.text = str(Global.score)

func _on_level_lives_changed() -> void:
	lives.text = str(Global.lives)
