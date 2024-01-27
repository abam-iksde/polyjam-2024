extends Node3D

func _ready():
	%transition.force_state(true)
	%transition.target = false
	GameState.lost = false
	Motion.reset()


func _physics_process(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		%transition.target = true
	if %transition.hidden:
		get_tree().change_scene_to_file('res://scenes/main_scene.tscn')
