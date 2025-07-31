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

func _process(delta: float) -> void:
	pass

func _on_train_stopper_area_entered(area: Area3D) -> void:
	if area.is_in_group("train"):
		train_haunted.can_move = false
