class_name Obstacle
extends Area3D


var rot := 0.0
var animation_speed := 0.0
var animation_frame := 0.0


func _physics_process(delta: float) -> void:
	delta = Motion.get_delta(delta)
	rot -= delta * 2*PI * Motion.movement_speed
	if rot < -3.0 * PI:
		queue_free()
	rotation.x = min(rot, -PI)
	animation_frame += animation_speed * delta
	get_node('sprite').frame = int(animation_frame) % get_node('sprite').hframes
