extends TextureRect


func _physics_process(delta: float) -> void:
	position.x -= delta * 200.0
	if position.x < -$box.size.x:
		queue_free()
