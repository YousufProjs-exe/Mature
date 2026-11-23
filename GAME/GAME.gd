extends Node2D

@export var speed := 45.0
@onready var bg1: Sprite2D = $Main
@onready var bg2: Sprite2D = $Main2
var bg_width: float

func _ready():
	bg_width = bg1.texture.get_width() * bg1.global_scale.x
	bg2.global_position = bg1.global_position + Vector2(bg_width, 0)
	
func _process(delta):
	var movement = speed * delta
	bg1.global_position.x -= movement
	bg2.global_position.x -= movement
	
	if bg1.global_position.x + bg_width / 2 <= 0:
		bg1.global_position.x = bg2.global_position.x + bg_width
	if bg2.global_position.x + bg_width / 2 <= 0:
		bg2.global_position.x = bg1.global_position.x + bg_width
