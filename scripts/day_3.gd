extends Node3D

@onready var train_passby_1: Node3D = $"train-passby1"
@onready var train_passby_2: Node3D = $"train-passby2"
@onready var train_haunted: Node3D = $"train-haunted"
@onready var light: MeshInstance3D = $map/light
@onready var light_2: MeshInstance3D = $map/light2
@onready var light_3: MeshInstance3D = $map/light3
@onready var light_7: MeshInstance3D = $map/light7
@onready var light_4: MeshInstance3D = $map/light4
@onready var light_6: MeshInstance3D = $map/light6
@onready var trash_can_2: MeshInstance3D = $map/trash_can2
@onready var train_winning: Node3D = $"train-winning"
@onready var player_raycast: RayCast3D = $player/cam_anchor/cam/raycast
@onready var player_tip_text: Label = $player/cam_anchor/cam/UI/tip
@onready var player_crosshair2: TextureRect = $player/cam_anchor/cam/UI/crosshair2

var DEATH_2 = load("res://game_scenes/death2.tscn")
var DEATH = load("res://game_scenes/death.tscn")
var DAY4 = load("res://game_scenes/day4.tscn")

var htrain: bool = true

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	train_passby_1.show()
	train_passby_1.can_move = true
	await get_tree().create_timer(12.0).timeout
	train_passby_1.hide()
	await get_tree().create_timer(5.0).timeout
	train_passby_2.show()
	train_passby_2.can_move = true
	await get_tree().create_timer(10.0).timeout
	light.hide()
	light_2.hide()
	light_3.hide()
	light_4.hide()
	light_6.hide()
	light_7.hide()
	train_passby_2.hide()
	trash_can_2.hide()
	await get_tree().create_timer(3.0).timeout
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	light_7.show()
	await get_tree().create_timer(5.0).timeout
	train_haunted.show()
	train_haunted.can_move = true
	await get_tree().create_timer(12.0).timeout
	train_haunted.can_move = true
	await get_tree().create_timer(7.0).timeout
	light.hide()
	light_2.hide()
	light_3.hide()
	light_4.hide()
	light_6.hide()
	light_7.hide()
	htrain = false
	train_haunted.hide()
	trash_can_2.show()
	await get_tree().create_timer(2.0).timeout
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	light_7.show()
	await get_tree().create_timer(6.0).timeout
	train_winning.show()
	train_winning.can_move = true
	await get_tree().create_timer(15.0).timeout
	train_winning.can_move = true
	await get_tree().create_timer(15.0).timeout
	get_tree().change_scene_to_packed(DEATH_2)

func _process(delta: float) -> void:
		if player_raycast.is_colliding() and player_raycast.get_collider().is_in_group("train"):
			player_tip_text.show()
			player_crosshair2.show()
			player_tip_text.text = "Go home?"
			if Input.is_action_just_pressed("interact"):
				player_tip_text.hide()
				player_crosshair2.hide()
				if htrain:
					get_tree().change_scene_to_packed(DEATH)
				else:
					get_tree().change_scene_to_packed(DAY4)
		else:
			player_tip_text.hide()
			player_crosshair2.hide()

func _on_train_stopper_area_entered(area: Area3D) -> void:
	if area.is_in_group("train"):
		train_haunted.can_move = false
		train_winning.can_move = false
