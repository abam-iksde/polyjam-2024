extends Node


var movement_speed := 0.3
var head_speed := 0.33
var time_scale := 1.0


func get_delta(from: float):
	return from * time_scale
