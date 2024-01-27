extends AudioStreamPlayer


func set_volume(volume: float) -> void:
	volume_db = -(1.0-volume) * 20.0



func play_song(path: String):
	if playing:
		stop()
	stream = load(path)
	play()
