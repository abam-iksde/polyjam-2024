extends Node


const HEAD_MAX_SPEED = 0.23
const HEAD_HANDICAPPED_SPEED = 0.15
const MOVEMENT_MAX_SPEED = 0.2


var movement_speed := MOVEMENT_MAX_SPEED
var head_speed := HEAD_MAX_SPEED
var time_scale := 1.0


# i hate myself for doing this
var minigame = null


func get_delta(from: float) -> float:
	return from * time_scale


func interpolate(a: float, b: float, weight: float) -> float:
	if b > a:
		a += abs(weight)
		if a >= b:
			return b
		return a
	a -= abs(weight)
	if a <= b:
		return b
	return a


func reset():
	movement_speed = MOVEMENT_MAX_SPEED
	head_speed = HEAD_MAX_SPEED
	time_scale = 1.0
