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

func _process(delta: float) -> void:
	pass
