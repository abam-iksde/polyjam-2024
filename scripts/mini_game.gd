extends KeepAspect


const GAMES = {
	'soap': preload('res://scenes/mini_games/soap.tscn'),
	'dance': preload('res://scenes/mini_games/dance.tscn'),
	'pie': preload('res://scenes/mini_games/pie.tscn'),
}


const BASE_SIZE = Vector2(480.0/1600.0, 266.0/900.0)
var view_position := 0.0


var game = null


func _ready():
	Motion.minigame = self


func start_game(name_: String) -> void:
	game = GAMES[name_].instantiate()
	add_child(game)
	Motion.time_scale = 0.3


func update_game_position():
	if game:
		game.position = Vector2(size.x/2.0 - size.x * BASE_SIZE.x * 0.5, size.y + size.y * view_position * 0.32)
		game.scale = size/Vector2(1600.0, 900.0)


func _physics_process(delta: float) -> void:
	update_game_position()
	if not game:
		if Input.is_key_pressed(KEY_0):
			start_game('soap')
		#if Input.is_key_pressed(KEY_9):
			#start_game('dance')
		#if Input.is_key_pressed(KEY_0):
			#start_game('pie')
		return
	if game.state == 'started':
		view_position -= delta * 2.0
		if view_position <= -1.0:
			game.state = 'going'
			view_position = -1.0
		return
	if game.state == 'done' or game.state == 'lost' or game.state == 'won':
		if game.state == 'won':
			Motion.head_speed = Motion.HEAD_HANDICAPPED_SPEED - (Motion.HEAD_HANDICAPPED_SPEED * 0.5 * game.score)
		game.state = 'done'
		view_position += delta * 2.0
		if view_position >= 0.0:
			game.queue_free()
			game = null
			Motion.time_scale = 1.0
			view_position = 0.0
			return
		return
