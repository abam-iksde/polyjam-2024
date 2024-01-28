extends Node3D


var sounds = [
	preload("res://audio/head/head_1.wav"),
	preload("res://audio/head/head_2.wav"),
	preload("res://audio/head/head_3.wav"),
	preload("res://audio/head/head_4.wav"),
	preload("res://audio/head/head_5.wav"),
	preload("res://audio/head/head_6.wav"),
]

var sound_now = null


@onready var sprite := get_node('sprite') as Sprite3D
var proximity := 1.0


func _physics_process(delta: float) -> void:
	if not is_instance_valid(sound_now):
		sound_now = Audio.spawn_sound_effect("SFX", sounds[randi() % len(sounds)], [], 10.0)
	delta = Motion.get_delta(delta)
	Motion.head_speed = lerpf(Motion.head_speed, Motion.HEAD_MAX_SPEED, delta * 0.6)
	proximity = min(proximity - (Motion.head_speed - Motion.movement_speed) * delta, 1.0)
	if proximity < 0.9:
		Tutorial.discover('face')
	if proximity < 0.0:
		GameState.lost = true
	var one_minus_proximity := (1.0-proximity)
	sprite.scale = Vector3(1.0, 1.0, 1.0) * (0.7 + 0.7 * one_minus_proximity)
	sprite.position.y = -1.0 + one_minus_proximity*2.0
	var lightness := 0.4 + 0.6 * one_minus_proximity
	sprite.modulate = Color(lightness, lightness, lightness, 1.0)
