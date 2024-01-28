extends Control


var locked := false

@export var ui_button = preload("res://audio/sfx/ui_button.wav")
@export var ui_hover = preload("res://audio/sfx/hover_ui.wav")

@onready var options = [
	{ visual = %menu_start, go = start_game },
	{ visual = %menu_credits, go = goto_credits },
	{ visual = %menu_exit, go = exit },
]


func _ready():
	MusicPlayer.play_song("res://audio/music/music_menu.ogg")
	%transition.force_state(true)
	%transition.target = false


func _physics_process(delta):
	if %transition.hidden and locked:
		options[GameState.main_menu_option].go.call()
	if locked:
		return
	if Input.is_action_just_pressed("ui_up"):
		Audio.spawn_sound_effect( "SFX" , ui_hover ,[18] )
		GameState.main_menu_option -= 1
	if Input.is_action_just_pressed("ui_down"):
		Audio.spawn_sound_effect( "SFX" , ui_hover ,[18] )
		GameState.main_menu_option += 1
	GameState.main_menu_option = wrap(GameState.main_menu_option, 0, len(options))
	highlight_option(GameState.main_menu_option)
	if Input.is_action_just_pressed('ui_accept'):
		Audio.spawn_sound_effect( "SFX" , ui_button ,[18] )
		locked = true
		%transition.target = true


func highlight_option(index: int):
	for i in range(len(options)):
		options[i].visual.visible = i == index


func start_game():
	GameState.restart()
	Motion.reset()
	get_tree().change_scene_to_file('res://scenes/cutscene_fmv.tscn')


func goto_credits():
	get_tree().change_scene_to_file('res://scenes/credits.tscn')


func exit():
	get_tree().quit()
