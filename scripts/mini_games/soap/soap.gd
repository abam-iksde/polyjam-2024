extends Control


var state := 'started'
var score := 0.0


@onready var view := get_node('game') as Control
@onready var foot := get_node('game/foot') as TextureRect
@onready var soap := get_node('game/soap') as TextureRect


var foot_velocity := Vector2(0.0, 0.0)


func _ready():
	foot.position.x = randf() * (view.size.x - foot.size.x)
	soap.position.x = randf() * (view.size.x - soap.size.x)


func _physics_process(delta: float) -> void:
	if state != 'going':
		return
	foot_velocity.x += delta * Input.get_axis('mg_left', 'mg_right') * 1024.0
	foot_velocity.y += delta * 512.0
	foot.position += foot_velocity * delta
	if Box.collides(foot.get_node('bounding_box'), soap.get_node('bounding_box')):
		state = 'won'
		score = 1.0
		return
	if foot.position.y >= 0.0:
		foot.position.y = 0.0
		state = 'lost'
