extends Node3D

@onready var light_1: OmniLight3D = $map/light3/OmniLight3D
@onready var light_2: OmniLight3D = $map/light4/OmniLight3D
@onready var light_timer_1: Timer = $light_timer_1
@onready var light_timer_2: Timer = $light_timer_2
@onready var credit_menu: CanvasLayer = $Ui/credit_menu
@onready var main_menu: CanvasLayer = $Ui/main_menu
@onready var man_anim: AnimationPlayer = $map/man/AnimationPlayer

const DAY_0 = preload("res://game_scenes/day0.tscn")

func _ready():
	light_timer_1.timeout.connect(_on_light_timer_1_timeout)
	light_timer_2.timeout.connect(_on_light_timer_2_timeout)
	light_timer_1.start()
	light_timer_2.start()
	ManAnimate()

func _on_light_timer_1_timeout():
	flicker_light(light_1)

func _on_light_timer_2_timeout():
	flicker_light(light_2)

func flicker_light(light: OmniLight3D) -> void:
	light.visible = false
	var off_time = randf_range(0.2, 3.2)
	await get_tree().create_timer(off_time).timeout
	light.visible = true

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
