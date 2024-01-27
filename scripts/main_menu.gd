extends Control


var locked := false

@onready var options = [
	{ visual = %menu_start, go = start_game },
	{ visual = %menu_credits, go = goto_credits },
	{ visual = %menu_exit, go = exit },
]


func _ready():
	%transition.force_state(true)
	%transition.target = false


func _physics_process(delta):
	if %transition.hidden and locked:
		options[GameState.main_menu_option].go.call()
	if locked:
		return
	if Input.is_action_just_pressed("ui_up"):
		GameState.main_menu_option -= 1
	if Input.is_action_just_pressed("ui_down"):
		GameState.main_menu_option += 1
	GameState.main_menu_option = GameState.main_menu_option % len(options)
	highlight_option(GameState.main_menu_option)
	if Input.is_action_just_pressed('ui_accept'):
		locked = true
		%transition.target = true


func highlight_option(index: int):
	for i in range(len(options)):
		options[i].visual.visible = i == index


func start_game():
	GameState.restart()
	Motion.reset()
	get_tree().change_scene_to_file('res://scenes/main_scene.tscn')


func goto_credits():
	pass


func exit():
	get_tree().quit()
