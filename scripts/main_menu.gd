extends Node3D

@onready var light_1: OmniLight3D = $map/light3/OmniLight3D
@onready var light_2: OmniLight3D = $map/light4/OmniLight3D
@onready var light_timer_1: Timer = $light_timer_1
@onready var light_timer_2: Timer = $light_timer_2
@onready var credit_menu: CanvasLayer = $Ui/credit_menu
@onready var main_menu: CanvasLayer = $Ui/main_menu
@onready var man_anim: AnimationPlayer = $map/man/AnimationPlayer
@onready var light_3: MeshInstance3D = $map/light3
@onready var light_4: MeshInstance3D = $map/light4
@onready var main_menu_audio: AudioStreamPlayer = $main_menu_audio

var DAY_0 = load("res://game_scenes/day0.tscn")
const MAIN_MENU_s = preload("res://sounds/main_menu.wav")

func _ready():
	main_menu_audio.stream = MAIN_MENU_s
	main_menu_audio.play()
	light_timer_1.timeout.connect(_on_light_timer_1_timeout)
	light_timer_2.timeout.connect(_on_light_timer_2_timeout)
	light_timer_1.start()
	light_timer_2.start()
	ManAnimate()

func _on_light_timer_1_timeout():
	flicker_light(light_1, light_3)

func _on_light_timer_2_timeout():
	flicker_light(light_2, light_4)

func flicker_light(light: OmniLight3D, mesh: MeshInstance3D) -> void:
	light.visible = false
	mesh.visible = false
	var off_time = randf_range(0.2, 3.2)
	await get_tree().create_timer(off_time).timeout
	light.visible = true
	mesh.visible = true

func ManAnimate() -> void:
	man_anim.play("mixamo_com")

func _on_credit_button_pressed() -> void:
	credit_menu.show()
	main_menu.hide()

func _on_back_button_pressed() -> void:
	credit_menu.hide()
	main_menu.show()

func _on_man_animation_player_animation_finished(anim_name: StringName) -> void:
	ManAnimate()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(DAY_0)
