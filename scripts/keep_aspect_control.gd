extends Control


const BUBBLES = [
	preload('res://scenes/speech_bubble.tscn'),
]

const MINIGAME_BUBBLES = [
	preload('res://scenes/bubbles/speech_bubble_dance2.tscn'),
]


var next := randi() % 6


func on_size_changed():
	var viewport_size := Vector2(get_viewport().size)
	var new_scale := viewport_size.x / size.x
	if size.y > viewport_size.y:
		new_scale = viewport_size.y / size.y
	scale = Vector2(new_scale, new_scale)
	position = (viewport_size-size*scale)/2.0


func _ready():
	on_size_changed()
	get_viewport().connect('size_changed', on_size_changed)


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
