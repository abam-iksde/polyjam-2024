extends Node


var lost := false

var score := 0:
	set(new_score):
		score = new_score
		if is_instance_valid(score_label):
			score_label.text = 'SCORE   %s' % [str(score)]

var score_label: Label = null
