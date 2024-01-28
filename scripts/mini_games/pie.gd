extends Control


const MARKER_SPEED = 900.0


var state := 'started'
var score := 0.0

var _state := 0


@onready var marker := get_node('game/marker') as ColorRect
@onready var sweet_spot: Array[ColorRect] = [
	get_node('game/sweet_spot1') as ColorRect,
	get_node('game/sweet_spot2') as ColorRect,
]


var direction := 1.0
var stopped := false
var verdict_countdown := 2.0


func _physics_process(delta: float) -> void:
	if state != 'going':
		return
	Tutorial.discover('pie')
	if stopped:
		verdict_countdown -= delta
		if verdict_countdown > 0.0:
			return
		if _state == 1:
			state = 'lost'
		else:
			state = 'won'
		return
	marker.position.x += direction * MARKER_SPEED * delta
	if marker.position.x <= 0.0:
		marker.position.x = 0.0
		direction = 1.0
	elif marker.position.x >= 470.0:
		marker.position.x = 470.0
		direction = -1.0
	if Input.is_action_just_pressed("mg_activate_1"):
		stopped = true
		var distance_between := sweet_spot[1].position.x - sweet_spot[0].position.x
		var marker_relative := marker.position.x - sweet_spot[0].position.x
		var distance_to_center := distance_between/2.0
		var marker_distance = abs(distance_to_center - marker_relative)
		score = 0.4 + ((distance_to_center-marker_distance)/distance_to_center) * 0.6
		if score < 0.4:
			_state = 1
			get_node('game/background2').texture = preload('res://textures/mini_games/Pie/pie2.png')
			return
		_state = 2
		get_node('game/background2').texture = preload('res://textures/mini_games/Pie/pie1.png')
