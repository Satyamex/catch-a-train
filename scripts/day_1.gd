extends Node3D

@onready var train_passby_1: Node3D = $"train-passby1"
@onready var train_passby_2: Node3D = $"train-passby2"
@onready var light: MeshInstance3D = $map/light
@onready var light_2: MeshInstance3D = $map/light2
@onready var light_3: MeshInstance3D = $map/light3
@onready var light_7: MeshInstance3D = $map/light7
@onready var light_4: MeshInstance3D = $map/light4
@onready var light_6: MeshInstance3D = $map/light6
@onready var real_poster1: MeshInstance3D = $map/Poster_02
@onready var real_poster2: MeshInstance3D = $map/Poster_03
@onready var fake_poster1: MeshInstance3D = $map/Poster_09
@onready var fake_poster2: MeshInstance3D = $map/Poster_10
@onready var man: Node3D = $man
@onready var train_haunted: Node3D = $"train-haunted"
@onready var train_stopper: Area3D = $train_stopper
@onready var player_raycast: RayCast3D = $player/cam_anchor/cam/raycast
@onready var player_tip_text: Label = $player/cam_anchor/cam/UI/tip
@onready var train_winning: Node3D = $"train-winning"
@onready var player: CharacterBody3D = $player
@onready var player_crosshair2: TextureRect = $player/cam_anchor/cam/UI/crosshair2

const LOOSE_SCREEN = preload("res://game_scenes/death.tscn")
const DEATH_2 = preload("res://game_scenes/death2.tscn")
const WIN_SCREEN = preload("res://game_scenes/main_menu.tscn")

var interacted_train: bool = false
var haunted_train_passed: bool = false

func _ready() -> void:
	await get_tree().create_timer(6.0).timeout
	train_passby_1.show()
	train_passby_1.can_move = true
	await get_tree().create_timer(20.0).timeout
	train_passby_1.hide()
	train_passby_2.show()
	train_passby_2.can_move = true
	await get_tree().create_timer(10.0).timeout
	light.hide()
	light_2.hide()
	light_3.hide()
	light_4.hide()
	light_6.hide()
	light_7.hide()
	real_poster1.hide()
	real_poster2.hide()
	fake_poster1.show()
	fake_poster2.show()
	man.queue_free()
	await get_tree().create_timer(10.0).timeout
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	light_7.show()
	train_passby_2.hide()
	train_haunted.show()
	train_haunted.can_move = true
	await get_tree().create_timer(20.0).timeout
	train_haunted.can_move = true
	haunted_train_passed = true
	await get_tree().create_timer(5.0).timeout
	train_haunted.hide()
	light.hide()
	light_2.hide()
	light_3.hide()
	light_4.hide()
	light_6.hide()
	light_7.hide()
	real_poster1.show()
	real_poster2.show()
	fake_poster1.hide()
	fake_poster2.hide()
	await get_tree().create_timer(3.0).timeout
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	light_7.show()
	train_winning.show()
	train_winning.can_move = true
	await get_tree().create_timer(14.0).timeout
	train_winning.can_move = true
	await get_tree().create_timer(10.0).timeout
	player.game_paused = true
	get_tree().change_scene_to_packed(DEATH_2)

func _on_train_stopper_area_entered(area: Area3D) -> void:
	var train = area.get_parent()
	if train.is_in_group("train"):
		train.can_move = false

func _process(delta: float) -> void:
		if player_raycast.is_colliding() and player_raycast.get_collider().is_in_group("train") and not interacted_train:
			player_tip_text.show()
			player_crosshair2.show()
			player_tip_text.text = "Go home?"
			if Input.is_action_just_pressed("interact"):
				player_tip_text.hide()
				player_crosshair2.hide()
				if not haunted_train_passed:
					interacted_train = true
					get_tree().change_scene_to_packed(LOOSE_SCREEN)
					player.game_paused = true
				else:
					get_tree().change_scene_to_packed(WIN_SCREEN)
		else:
			player_tip_text.hide()
			player_crosshair2.hide()

func _on_train_stopper_body_entered(body: Node3D) -> void:
	var train = body.get_parent()
	if train.is_in_group("train"):
		train.can_move = false
