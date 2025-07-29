extends Node3D

var train_speed: int = 10
var can_move: bool = false

func _process(delta: float) -> void:
	if can_move:
		global_position.z += train_speed * delta
