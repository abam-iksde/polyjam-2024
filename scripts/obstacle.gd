class_name Obstacle
extends Area3D


var rot := 0.0
var animation_speed := 0.0
var animation_frame := 0.0


var type := 'Obstacle'


var sound_effect: Resource


func _physics_process(delta: float) -> void:
	delta = Motion.get_delta(delta)
	rot -= delta * 2*PI * Motion.movement_speed
	if rot <= -1.75 * PI and rot >= -2.0 * PI and not Motion.minigame.game:
		Tutorial.discover('obstacle' if type == 'Obstacle' else 'collectibles')
	if rot < -3.0 * PI:
		queue_free()
	rotation.x = min(rot, -PI)
	animation_frame += animation_speed * delta
	get_node('sprite').frame = int(animation_frame) % get_node('sprite').hframes
