class_name Obstacle
extends Area3D


var rot := 0.0


func _physics_process(delta: float) -> void:
	delta = Motion.get_delta(delta)
	rot -= delta * 2*PI * Motion.movement_speed
	if rot < -3.0 * PI:
		queue_free()
	rotation.x = min(rot, -PI)
