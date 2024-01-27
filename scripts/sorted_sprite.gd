extends Sprite3D


func _physics_process(delta: float) -> void:
	render_priority = int(global_position.z * 41.0)
