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

func _ready() -> void:
	await get_tree().create_timer(6.0).timeout
	train_passby_1.can_move = true
	await get_tree().create_timer(20.0).timeout
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
	train_haunted.can_move = true
	train_stopper.show()
	await get_tree().create_timer(30.0).timeout
	train_passby_1.queue_free()
	train_passby_2.queue_free()

func _on_train_stopper_area_entered(area: Area3D) -> void:
	if area.is_in_group("train"):
		train_haunted.can_move = false
