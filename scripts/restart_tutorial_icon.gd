extends Node3D


var rot := 0.0


func _physics_process(delta):
	rot = lerpf(rot, 0.0, delta * 10.0)
	rotation.z = rot
