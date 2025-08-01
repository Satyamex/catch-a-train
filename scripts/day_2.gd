extends Node3D

@onready var man_anim: AnimationPlayer = $man/AnimationPlayer
@onready var train_passby_1: Node3D = $"train-passby1"
@onready var train_haunted: Node3D = $"train-haunted"
@onready var train_haunted_2: Node3D = $"train-haunted2"
@onready var train_winning: Node3D = $"train-winning"
@onready var light: MeshInstance3D = $map/light
@onready var light_2: MeshInstance3D = $map/light2
@onready var light_3: MeshInstance3D = $map/light3
@onready var light_7: MeshInstance3D = $map/light7
@onready var light_4: MeshInstance3D = $map/light4
@onready var light_6: MeshInstance3D = $map/light6
@onready var light_8: MeshInstance3D = $map/light8
@onready var light_anim: AnimationPlayer = $map/light8/AnimationPlayer
@onready var player_raycast: RayCast3D = $player/cam_anchor/cam/raycast
@onready var player_tip_text: Label = $player/cam_anchor/cam/UI/tip
@onready var player_crosshair2: TextureRect = $player/cam_anchor/cam/UI/crosshair2
@onready var demon_eyes: Node3D = $demon_eyes

var DEATH = load("res://game_scenes/death.tscn")
var DEATH_2 = load("res://game_scenes/death2.tscn")
var DAY3 = load("res://game_scenes/day3.tscn")

var htrain: bool = true
var htrain2: bool = true

func _ready() -> void:
	man_anim.play("mixamo_com")
	await get_tree().create_timer(6.0).timeout
	train_passby_1.show()
	train_passby_1.can_move = true
	await get_tree().create_timer(12.0).timeout
	train_passby_1.hide()
	light.hide()
	light_2.hide()
	light_3.hide()
	light_7.hide()
	light_4.hide()
	light_6.hide()
	await get_tree().create_timer(2.0).timeout
	light_8.show()
	light_anim.play("fling")
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	train_haunted.show()
	train_haunted.can_move = true
	await get_tree().create_timer(20.0).timeout
	htrain = false
	train_haunted.can_move = true
	await get_tree().create_timer(6.0).timeout
	train_haunted.hide()
	light.hide()
	light_2.hide()
	light_3.hide()
	light_8.hide()
	light_4.hide()
	light_6.hide()
	await get_tree().create_timer(1.0).timeout
	demon_eyes.show()
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	light_7.show()
	await get_tree().create_timer(5.0).timeout
	train_haunted_2.show()
	train_haunted_2.can_move = true
	await get_tree().create_timer(25.0).timeout
	train_haunted_2.can_move = true
	await get_tree().create_timer(10.0).timeout
	light.hide()
	light_2.hide()
	light_3.hide()
	light_8.hide()
	light_4.hide()
	light_6.hide()
	light_7.hide()
	demon_eyes.hide()
	train_haunted_2.hide()
	await get_tree().create_timer(6.0).timeout
	light.show()
	light_2.show()
	light_3.show()
	light_4.show()
	light_6.show()
	htrain2 = false
	light_7.show()
	train_winning.show()
	train_winning.can_move = true
	await get_tree().create_timer(25.0).timeout
	train_winning.can_move = true
	await get_tree().create_timer(8.0).timeout
	get_tree().change_scene_to_packed(DEATH_2)

func _process(delta: float) -> void:
		if player_raycast.is_colliding() and player_raycast.get_collider().is_in_group("train"):
			player_tip_text.show()
			player_crosshair2.show()
			player_tip_text.text = "Go home?"
			if Input.is_action_just_pressed("interact"):
				player_tip_text.hide()
				player_crosshair2.hide()
				if htrain or htrain2:
					get_tree().change_scene_to_packed(DEATH)
				else:
					get_tree().change_scene_to_packed(DAY3)
		else:
			player_tip_text.hide()
			player_crosshair2.hide()

func _on_man_animation_player_animation_finished(anim_name: StringName) -> void:
	man_anim.play("mixamo_com")

func _on_light_animation_player_animation_finished(anim_name: StringName) -> void:
	light_anim.play("fling")

func _on_train_stopper_area_entered(area: Area3D) -> void:
	if area.is_in_group("train"):
		train_haunted.can_move = false
		train_haunted_2.can_move = false
		train_winning.can_move = false
