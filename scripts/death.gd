extends Node3D

var MAIN_MENU = load("res://game_scenes/main_menu.tscn")

@onready var cutscene: AnimationPlayer = $cutscene

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	cutscene.play("death")
	await get_tree().create_timer(8.91).timeout
	get_tree().change_scene_to_packed(MAIN_MENU)
