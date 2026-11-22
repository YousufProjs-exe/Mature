extends Node2D

@export var witch_speed := 220.0
@export var boy_speed := 260.0
@onready var witch: Sprite2D = $Witch
@onready var bot: AnimatedSprite2D = $bot
@onready var boy: Sprite2D = $Boy
@onready var player: Node2D = $Player
var witch_moving := true
var boy_moving := false

func _ready():
	bot.animation_finished.connect(_on_bot_animation_finished)
	boy.hide()
	player.hide()
	bot.play()
	
func _process(delta):
	if witch_moving:
		witch.global_position.x += witch_speed * delta
		if witch.global_position.x > get_viewport_rect().size.x + witch.texture.get_width():
			witch_moving = false
			witch.hide()
			
	if boy_moving:
		boy.global_position.x -= boy_speed * delta
		if boy.global_position.x > get_viewport_rect().size.x + boy.texture.get_width():
			boy_moving = false
			boy.hide()
			
func _on_bot_animation_finished():
	bot.stop()
	bot.hide()
	boy.global_position = bot.global_position
	player.global_position = bot.global_position
	boy.show()
	player.show()
	boy_moving = true
