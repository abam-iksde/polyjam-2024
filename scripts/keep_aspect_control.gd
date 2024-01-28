class_name KeepAspectControl
extends Control


func on_size_changed():
	var viewport_size := Vector2(get_viewport().size)
	var new_scale := viewport_size.x / size.x
	if size.y * new_scale > viewport_size.y:
		new_scale = viewport_size.y / size.y
	scale = Vector2(new_scale, new_scale)
	position = (viewport_size-size*scale)/2.0


func _ready():
	on_size_changed()
	get_viewport().connect('size_changed', on_size_changed)
