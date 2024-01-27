extends Node


const HEAD_MAX_SPEED = 0.23
const HEAD_HANDICAPPED_SPEED = 0.15
const MOVEMENT_MAX_SPEED = 0.2


var movement_speed := MOVEMENT_MAX_SPEED
var head_speed := HEAD_MAX_SPEED
var time_scale := 1.0


func get_delta(from: float):
	return from * time_scale
