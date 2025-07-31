extends CharacterBody3D

@onready var cam_anchor: Node3D = $cam_anchor
@onready var cam: Camera3D = $cam_anchor/cam

var cam_sens: float = 0.0025
var game_paused: bool = false
var jump_velocity: float
var current_speed: float = 7.0
var acceleration: float = 100.0
var deceleration: float = 10.0
var can_look: bool = true
var can_move: bool = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if !game_paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			if can_look:
				rotate_y(-event.relative.x * cam_sens)
				cam_anchor.rotate_x(-event.relative.y * cam_sens)
				cam_anchor.rotation.x = clamp(cam_anchor.rotation.x, deg_to_rad(-85), deg_to_rad(85))
	if game_paused:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_velocity = randf_range(3.5, 4.5)
		velocity.y = jump_velocity
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO and can_move:
		velocity.x = lerpf(velocity.x, direction.x * current_speed, acceleration * delta)
		velocity.z = lerpf(velocity.z, direction.z * current_speed, acceleration * delta)
	else:
		velocity.x = lerpf(velocity.x, 0.0, deceleration * delta)
		velocity.z = lerpf(velocity.z, 0.0, deceleration * delta)
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		game_paused = !game_paused
