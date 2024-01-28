extends Node

var last_input := 'keyboard'


func _input(event):
	if event is InputEventKey:
		last_input = 'keyboard'
		return
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		last_input = 'gamepad'


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
