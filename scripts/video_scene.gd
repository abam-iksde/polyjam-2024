extends KeepAspectControl


@onready var frame := get_node('frame') as TextureRect

@export var next_scene: Resource
@export var frame_base_path: String
@export var n_frames: int
@export var frames_per_second: float = 20.0
@export var n_digits := 3


var frame_n := 0.0

var frames = []


func _ready():
	super._ready()
	for i in range(n_frames):
		frames.push_back(load(frame_base_path + get_frame_n_string(i+1) + '.jpg'))
	frame.texture = frames[0]


func goto_next():
	get_tree().change_scene_to_packed(next_scene)


func _physics_process(delta):
	frame_n += delta * frames_per_second
	var frame_i = int(frame_n)
	if frame_i >= len(frames) or Input.is_action_just_pressed('ui_accept'):
		goto_next()
		return
	frame.texture = frames[frame_i]


func get_frame_n_string(i: int) -> String:
	var string := str(i)
	while len(string) < n_digits:
		string = '0' + string
	return string
