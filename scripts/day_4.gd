extends Node3D

@onready var subtitle: Label = $UI/subtitle
@onready var train_haunted: Node3D = $"train-haunted"
@onready var train_haunted_2: Node3D = $"train-haunted2"
@onready var train_winning: Node3D = $"train-winning"
@onready var light: MeshInstance3D = $map/light
@onready var light_2: MeshInstance3D = $map/light2
@onready var light_3: MeshInstance3D = $map/light3
@onready var light_7: MeshInstance3D = $map/light7
@onready var light_4: MeshInstance3D = $map/light4
@onready var light_6: MeshInstance3D = $map/light6
@onready var demon_eyes: Node3D = $demon_eyes
@onready var map: MeshInstance3D = $map/metro_map2
@onready var real_map: MeshInstance3D = $map/metro_map
@onready var player_raycast: RayCast3D = $player/cam_anchor/cam/raycast
@onready var player_tip_text: Label = $player/cam_anchor/cam/UI/tip
@onready var player_crosshair2: TextureRect = $player/cam_anchor/cam/UI/crosshair2

var DEATH_2 = load("res://game_scenes/death2.tscn")
var DEATH = load("res://game_scenes/death.tscn")
var DAY5 = load("res://game_scenes/day5.tscn")

var haunted_trains_passed: bool = false

func _ready() -> void:
	subtitle.text = "tommowrow is my last day at work."
	await get_tree().create_timer(5.0).timeout
	subtitle.text = "finally... i will never come here again."
	await get_tree().create_timer(5.0).timeout
	subtitle.hide()
	await get_tree().create_timer(3.0).timeout
	light.hide()
	light_2.hide()
	light_3.hide()
	light_4.hide()
	light_6.hide()
	light_7.hide()
	demon_eyes.show()
	map.show()
	real_map.hide()
	await get_tree().create_timer(6.0).timeout
	demon_eyes.hide()
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	light_7.show()
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
	demon_eyes.show()
	real_map.show()
	map.hide()
	train_haunted.hide()
	await get_tree().create_timer(6.0).timeout
	demon_eyes.hide()
	light.show()
	light_2.show()
	light_3.show()
	light_6.show()
	light_7.show()
	train_haunted_2.show()
	train_haunted_2.can_move = true
	await get_tree().create_timer(13.0).timeout
	train_haunted_2.can_move = true
	await get_tree().create_timer(5.0).timeout
	demon_eyes.show()
	light.hide()
	light_2.hide()
	light_3.hide()
	light_4.hide()
	light_6.hide()
	light_7.hide()
	train_haunted_2.hide()
	await get_tree().create_timer(5.0).timeout
	demon_eyes.hide()
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	light_7.show()
	haunted_trains_passed = true
	await get_tree().create_timer(5.0).timeout
	train_winning.show()
	train_winning.can_move = true
	await get_tree().create_timer(14.0).timeout
	train_winning.can_move = true
	await get_tree().create_timer(7.0).timeout
	get_tree().change_scene_to_packed(DEATH_2)

func _on_train_stopper_area_entered(area: Area3D) -> void:
	if area.is_in_group("train"):
		train_haunted.can_move = false
		train_haunted_2.can_move = false
		train_winning.can_move = false

func _process(delta: float) -> void:
		if player_raycast.is_colliding() and player_raycast.get_collider().is_in_group("train"):
			player_tip_text.show()
			player_crosshair2.show()
			player_tip_text.text = "Go home?"
			if Input.is_action_just_pressed("interact"):
				player_tip_text.hide()
				player_crosshair2.hide()
				if !haunted_trains_passed:
					get_tree().change_scene_to_packed(DEATH)
				else:
					get_tree().change_scene_to_packed(DAY5)
		else:
			player_tip_text.hide()
			player_crosshair2.hide()
