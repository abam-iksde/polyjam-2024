@tool
extends Sprite2D


@export var size = Vector3(1.0, 1.0, 1.0):
	set(new_size):
		size = new_size
		generate()


@export var texture_scale := 1.0:
	set(new_scale):
		texture_scale = new_scale
		generate()


@export var texture_z_offset := 0.0

@export var animation_speed := 12.0


func _ready() -> void:
	if not Engine.is_editor_hint():
		return
	generate()


func generate():
	$collision.size = Vector2(size.x * 256.0, size.y * 256.0)
	scale = Vector2(texture_scale, texture_scale)
	$collision.scale = (1.0/texture_scale) * Vector2(1.0, 1.0)
	$collision.position = -$collision.size / 2.0 * $collision.scale
