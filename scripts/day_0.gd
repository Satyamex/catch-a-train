extends Node3D

signal interact_pressed

@onready var man_anims: AnimationPlayer = $"man/AnimationPlayer"
@onready var player_crosshair_2: TextureRect = $player/cam_anchor/cam/UI/crosshair2
@onready var player_raycast: RayCast3D = $player/cam_anchor/cam/raycast
@onready var player: CharacterBody3D = $player
@onready var dialogues: Label = $UI/dialogues
@onready var player_tip_text: Label = $player/cam_anchor/cam/UI/tip

var talked_to_man: bool = false

func _ready() -> void:
	play_anim()

func _on_man_animation_player_animation_finished(anim_name: StringName) -> void:
	play_anim()

func play_anim() -> void:
	man_anims.play("mixamo_com")

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		emit_signal("interact_pressed")

func _process(delta: float) -> void:
	if player_raycast.is_colliding() and player_raycast.get_collider().is_in_group("man") and not talked_to_man:
		player_crosshair_2.show()
		player_tip_text.show()
		player_tip_text.text = "Talk?"
		if Input.is_action_just_pressed("interact"):
			await man_talk()
	else:
		player_crosshair_2.hide()
		player_tip_text.hide()

func man_talk() -> void:
	player.can_look = false
	player.can_move = false
	dialogues.show()
	talked_to_man = true
	var dialogues_texts: Array[String] = [
		"hey there...", 
		"stranger!", 
		"I have heard...", 
		"she died here that day.", 
		"they say this place...", 
		"isn't just a train station anymore.",
		"some of these trains...", 
		"they’re cursed.", 
		"step into the wrong one...", 
		"and you're done.", 
		"no warning.", 
		"no mercy.",
		"you’ll have to look around...", 
		"very carefully.", 
		"anomalies...", 
		"flickering lights...",
		"replaced objects...", 
		"they all mean something bad.", 
		"each day...", 
		"things change.", 
		"the cursed trains...", 
		"never stay the same.", 
		"remember the details now...", 
		"while it’s still quiet.", 
		"it’s the only way...", 
		"to survive.", 
		"good luck...", 
		"stranger…", 
		"you'll need it."
	]
	for line in dialogues_texts:
		dialogues.text = line
		await self.interact_pressed
	player.can_look = true
	player.can_move = true
	dialogues.hide()
	player_tip_text.hide()
