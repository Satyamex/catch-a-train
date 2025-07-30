extends Node3D

const MAIN_MENU = preload("res://game_scenes/main_menu.tscn")

@onready var cutscene: AnimationPlayer = $cutscene

func _ready() -> void:
	cutscene.play("death")
	await get_tree().create_timer(9.0).timeout
	var scene = MAIN_MENU.instantiate()
	get_tree().root.call_deferred("add_child", scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = scene
