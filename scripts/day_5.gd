extends Node3D

@onready var light_blinking: MeshInstance3D = $map/light2
@onready var train_passby_1: Node3D = $"train-passby1"
@onready var train_haunted: Node3D = $"train-haunted"
var DEATH_2 = load("res://game_scenes/death2.tscn")
var htrain_passed: bool = false

func _ready() -> void:
	light_blink()
	await get_tree().create_timer(9.0).timeout
	train_passby_1.show()
	train_passby_1.can_move = true
	await get_tree().create_timer(16.0).timeout
	train_passby_1.hide()
	await get_tree().create_timer(4.0).timeout
	train_haunted.show()
	train_haunted.can_move = true
	await get_tree().create_timer(16.0).timeout
	train_haunted.can_move = true
	htrain_passed = true
	await get_tree().create_timer(16.0).timeout
	get_tree().change_scene_to_packed(DEATH_2)

func light_blink() -> void:
	light_blinking.hide()
	var rand: float
	if not htrain_passed:
		rand = randf_range(0.2, 0.6)
	else: 
		rand = randf_range(0.05, 0.2)
	await get_tree().create_timer(rand).timeout
	light_blinking.show()
	if not htrain_passed:
		rand = randf_range(0.2, 0.6)
	else: 
		rand = randf_range(0.05, 0.2)
	await get_tree().create_timer(rand).timeout
	light_blink()

func _on_train_stopper_area_entered(area: Area3D) -> void:
	train_haunted.can_move = false
