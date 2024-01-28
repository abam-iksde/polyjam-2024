extends Node


func spawn_sound_effect(bus: String, effect: Resource, pitch_range: Array[int] = [], boost: float = 0.0) -> Node:
	var new_sound_effect := AudioStreamPlayer.new()
	
	new_sound_effect.bus = bus
	new_sound_effect.stream = effect
	if boost:
		new_sound_effect.volume_db += boost
	
	if pitch_range and len(pitch_range) > 1:
		new_sound_effect.pitch_scale = randf_range(pitch_range[0], pitch_range[1])    
	
	new_sound_effect.finished.connect(new_sound_effect.queue_free)
	
	add_child(new_sound_effect)
	new_sound_effect.play()
	return new_sound_effect
