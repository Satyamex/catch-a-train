extends Node3D

const DAY2 = preload("res://game_scenes/main_menu.tscn")

@onready var cutscene: AnimationPlayer = $cutscene

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	cutscene.play("death")
	await get_tree().create_timer(8.3).timeout
	var scene = DAY2.instantiate()
	get_tree().root.call_deferred("add_child", scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = scene
