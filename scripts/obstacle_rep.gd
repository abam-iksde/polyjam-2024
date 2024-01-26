@tool
extends Sprite2D


@export var size = Vector3(1.0, 1.0, 1.0):
	set(new_size):
		size = new_size
		generate()


func _ready() -> void:
	if not Engine.is_editor_hint():
		return
	generate()


func generate():
	$collision.size = Vector2(size.x * 256.0, size.y * 256.0)
	$collision.position = -$collision.size / 2.0
