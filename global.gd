extends Node

@onready var viewport_size : Vector2 = get_viewport().get_visible_rect().size

const ASTEROID_EXPLOSION_COLOR:Color = Color(0.60,0.43,0.33)
const PLAYER_EXPLOSION_COLOR:Color = Color(1,1,1)

var lives:int = 3
var score:int = 0
