extends Control


var state := 'started'
var score := 0.4

@export var won_ui = preload("res://audio/sfx/soap_sfx.wav")



@onready var view := get_node('game') as Control
@onready var foot := get_node('game/foot') as Control
@onready var soap := get_node('game/soap') as Control


var foot_velocity := Vector2(0.0, 0.0)


func _ready():
	foot.position.x = randf() * (view.size.x - foot.size.x)
	soap.position.x = randf() * (view.size.x - soap.size.x)


func _physics_process(delta: float) -> void:
	if state != 'going':
		return
	Tutorial.discover('soap')
	foot_velocity.x += delta * Input.get_axis('mg_left', 'mg_right') * 1024.0
	foot_velocity.y += delta * 480.0
	foot.position += foot_velocity * delta
	if Box.collides(foot.get_node('bounding_box'), soap.get_node('bounding_box')):
		state = 'won'
		Audio.spawn_sound_effect( "SFX" , won_ui ,[18] )
		return
	if foot.position.y >= 0.0:
		foot.position.y = 0.0
		state = 'lost'
