class_name Box
extends Node


static func collides(a: Control, b: Control) -> bool:
	return (
		a.global_position.x + a.get_global_rect().size.x >= b.global_position.x and a.global_position.x < b.global_position.x + b.get_global_rect().size.x and
		a.global_position.y + a.get_global_rect().size.y >= b.global_position.y and a.global_position.y < b.global_position.y + b.get_global_rect().size.y
	)
