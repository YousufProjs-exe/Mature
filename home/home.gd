
extends Node2D

@export var snow_speed := 300.0
@export var jump_force := -550.0
@export var gravity := 1200.0
@export var witch_speed := 180.0
@onready var witch = $Witch2
@onready var snowguy = $Snowguy
@onready var start_button = $Button

var witch_direction := 1
var snow_velocity_y := 0.0
var ground_y := 0.0

func _ready():
	ground_y = snowguy.position.y
	start_button.pressed.connect(start_game)
	
func start_game():
	get_tree().change_scene_to_file("res://main/main.tscn");
	
func _process(delta):
	var screen_width = get_viewport_rect().size.x
	
	witch.position.x += witch_direction * witch_speed * delta
	witch.flip_h = witch_direction > 0
	
	if witch.position.x >= screen_width - 30:
		witch_direction = -1
	elif witch.position.x <= 30:
		witch_direction = 1
		
	var direction = 0
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction -= 1
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction += 1
	snowguy.position.x += direction * snow_speed * delta
	snowguy.position.x = clampf(snowguy.position.x, 20, screen_width - 20)
	
	if direction > 0:
		snowguy.flip_h = true
	elif direction < 0:
		snowguy.flip_h = false
	if Input.is_key_pressed(KEY_SPACE) and snowguy.position.y >= ground_y:
		snow_velocity_y = jump_force
		
	snow_velocity_y += gravity * delta
	snowguy.position.y += snow_velocity_y * delta
	if snowguy.position.y >= ground_y:
		snowguy.position.y = ground_y
		snow_velocity_y = 0
		
	var button_rect = start_button.get_global_rect().grow(25)
	if button_rect.has_point(snowguy.global_position):
		start_game()
