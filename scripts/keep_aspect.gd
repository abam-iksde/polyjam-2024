class_name KeepAspect
extends Control


@export var aspect_components := Vector2(16.0, 9.0)


func on_size_changed():
	var viewport_size := get_viewport().size as Vector2i
	var new_size := Vector2(viewport_size.x, viewport_size.x/aspect_components.x * aspect_components.y)
	if new_size.y <= viewport_size.y:
		size = new_size
	else:
		size = Vector2(viewport_size.y/aspect_components.y * aspect_components.x, viewport_size.y)
	position = (Vector2(viewport_size) - size)/2.0


func _ready():
	on_size_changed()
	get_viewport().connect('size_changed', on_size_changed)
