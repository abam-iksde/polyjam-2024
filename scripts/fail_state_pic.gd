extends Node3D


var accepted := false


func _ready():
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
