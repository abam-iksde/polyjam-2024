extends Node3D

@export var trombka = preload("res://audio/sfx/trombka.wav")

var accepted := false


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("LAUGH"), -100.0)
	Audio.spawn_sound_effect( "SFX" , trombka ,[18] )
	%transition.force_state(true)
	%transition.target = false
	GameState.lost = false
	Motion.reset()


func _physics_process(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		%transition.target = true
		accepted = true
	if %transition.hidden and accepted:
		get_tree().change_scene_to_file('res://scenes/main_menu.tscn')
