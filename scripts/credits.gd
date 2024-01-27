extends Control


var exiting := false


func _ready():
	%transition.force_state(true)
	%transition.target = false


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		%transition.target = true
		exiting = true
	
	if %transition.hidden and exiting:
		get_tree().change_scene_to_file('res://scenes/main_menu.tscn')
