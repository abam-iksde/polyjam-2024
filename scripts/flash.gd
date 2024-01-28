extends Control


var d := true
var flash_frequency := 0.25
var time := 0.0


func _physics_process(delta: float) -> void:
	time += delta
	if time >= flash_frequency:
		var color := 0.7 if d else 1.0
		modulate = Color(color, color, color, 1.0)
		time -= flash_frequency
		d = not d
