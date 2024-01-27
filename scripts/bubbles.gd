extends KeepAspectControl


const BUBBLES = [
	preload('res://scenes/bubbles/speech_bubble_flavor1.tscn'),
	preload('res://scenes/bubbles/speech_bubble_frick.tscn'),
]

const MINIGAME_BUBBLES = [
	preload('res://scenes/bubbles/speech_bubble_dance2.tscn'),
	preload('res://scenes/bubbles/speech_bubble_dance_3.tscn'),
	preload('res://scenes/bubbles/speech_bubble_dance_1.tscn'),
	preload('res://scenes/bubbles/speech_bubble_soap_3.tscn'),
	preload('res://scenes/bubbles/speech_bubble_soap_4.tscn'),
	preload('res://scenes/bubbles/speech_bubble_pie_1.tscn'),
	preload('res://scenes/bubbles/speech_bubble_pie_2.tscn'),
	preload('res://scenes/bubbles/speech_bubble_pie_3.tscn'),
]


var time = 0.0


func _physics_process(delta):
	time += Motion.get_delta(delta)
	if time > 1.0:
		time -= 1.0
		next -= 1
		var bubble = null
		if next <= 0:
			if Motion.minigame.game != null:
				return
			bubble = MINIGAME_BUBBLES[randi() % len(MINIGAME_BUBBLES)].instantiate()
			next = randi() % 6
		else:
			bubble = BUBBLES[randi() % len(BUBBLES)].instantiate()
		add_child(bubble)
