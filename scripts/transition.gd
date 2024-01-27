extends MeshInstance3D


var scale_range := Vector2(0.002, 0.7)
var target := false
var hidden := false


func _physics_process(delta: float) -> void:
	if target:
		var new_scale = Motion.interpolate(scale.x, scale_range.x, delta)
		if abs(new_scale-scale_range.x) < 0.001:
			hidden = true
		scale = Vector3(new_scale, new_scale, new_scale)
		return
	var new_scale = Motion.interpolate(scale.x, scale_range.y, delta * 1.5)
	scale = Vector3(new_scale, new_scale, new_scale)


func force_state(_hidden: bool) -> void:
	hidden = _hidden
	target = _hidden
	var new_scale = scale_range.x if _hidden else scale_range.y
	scale = Vector3(new_scale, new_scale, new_scale)
