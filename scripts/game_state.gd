extends Node


var lost := false

var score := 0:
	set(new_score):
		score = new_score
		if is_instance_valid(score_label):
			score_label.text = 'SCORE   %s' % [str(score + note_score)]

var note_score := 0:
	set(new_score):
		note_score = new_score
		if is_instance_valid(score_label):
			score_label.text = 'SCORE   %s' % [str(score + note_score)]

var score_label: Label = null


var main_menu_option := 0

var streak := 0
var max_streak := 0


var available_activators := [
	'mg_up',
	'mg_down',
	'mg_left',
	'mg_right',
]


func restart():
	score = 0
	lost = false
	available_activators = [
		'mg_up',
		'mg_down',
		'mg_left',
		'mg_right',
	]
	streak = 0
	max_streak = 0
