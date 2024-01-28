extends Control


@onready var button_textures = {
	keyboard = {
		move_left = get_node('move_left_keyboard'),
		move_right = get_node('move_right_keyboard'),
		jump = get_node('jump_keyboard'),
		mg_left = get_node('keyboard_minigame_left'),
		mg_right = get_node('keyboard_minigame_right'),
		mg_up = get_node('keyboard_minigame_up'),
		mg_down = get_node('keyboard_minigame_down'),
	},
	gamepad = {
		move_left = get_node('move_left_gamepad'),
		move_right = get_node('move_right_gamepad'),
		jump = get_node('jump_gamepad'),
		mg_left = get_node('gamepad_minigame_left'),
		mg_right = get_node('gamepad_minigame_right'),
		mg_up = get_node('gamepad_minigame_up'),
		mg_down = get_node('gamepad_minigame_down'),
	},
}

@export_enum('move_left', 'move_right', 'jump', 'mg_left', 'mg_right', 'mg_up', 'mg_down') var button := 'move_left'


func _physics_process(delta):
	for child in get_children():
		child.visible = false
	button_textures[LastInput.last_input][button].visible = true
