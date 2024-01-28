extends KeepAspectControl


@export var next_scene: Resource


func _ready():
	super._ready()
	$video_stream_player.play()
	$video_stream_player.connect('finished', goto_next)


func goto_next():
	get_tree().change_scene_to_packed(next_scene)


func _physics_process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		goto_next()
