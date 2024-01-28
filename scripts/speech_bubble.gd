@tool
extends Control


const ACTIVATORS = {
	'mg_up': preload('res://textures/buttons/Tutorial I.png'),
	'mg_down': preload('res://textures/buttons/Tutorial K.png'),
	'mg_left': preload('res://textures/buttons/Tutorial J.png'),
	'mg_right': preload('res://textures/buttons/TutoriaL.png'),
}


@export var texture_right := preload('res://textures/speechbubbles/Bubbles right/Bubl_soap_text_nr3.png'):
	set(new_texture):
		texture_right = new_texture
		generate()
@export var texture_left := preload('res://textures/speechbubbles/Bubbles left/Bubl_soap_text_nr3(left).png'):
	set(new_texture):
		texture_left = new_texture
		generate()


@onready var texture_right_node = get_node('pivot_scale/pivot_rotation/texture_right') as TextureRect
@onready var texture_left_node = get_node('pivot_scale/pivot_rotation/texture_left') as TextureRect
@onready var texture_right_button = get_node('button_right') as TextureRect
@onready var texture_left_button = get_node('button_left') as TextureRect

@onready var pivot_scale := get_node('pivot_scale') as Control
@onready var pivot_rotation := get_node('pivot_scale/pivot_rotation') as Control

var time_elapsed := 0.0

var activate_action := ''
var activated := false

var used_texture_node: TextureRect

@export var minigame := '':
	set(new_minigame):
		minigame = new_minigame
		generate()


@export var valid_thru := 1.0

@export_group('sounds left')
@export var sound_left_1: Resource
@export var sound_left_2: Resource
@export var sound_left_3: Resource
@export var sound_left_4: Resource
@export var sound_left_5: Resource
@export_group('sounds right')
@export var sound_right_1: Resource
@export var sound_right_2: Resource
@export var sound_right_3: Resource
@export var sound_right_4: Resource
@export var sound_right_5: Resource

var sounds_left = []
var sounds_right = []


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	delta = Motion.get_delta(delta)
	
	if activate_action != '' and Input.is_action_just_pressed(activate_action) and not activated and not Motion.minigame.game:
		Motion.minigame.start_game(minigame)
		time_elapsed = 0.25 + valid_thru
		activated = true
	
	time_elapsed += delta
	var init_animation_stage := minf(time_elapsed, 0.25)
	pivot_rotation.rotation_degrees = 180.0 - 180.0 * 4.0 * init_animation_stage
	used_texture_node.modulate.a = init_animation_stage * 4.0
	
	var last_animation_stage := time_elapsed - 0.25 - valid_thru
	if last_animation_stage <= 0.0:
		return
	var rotation_ := 180.0 * 4.0 * last_animation_stage
	pivot_rotation.rotation_degrees = rotation_
	used_texture_node.modulate.a = 1.0 - last_animation_stage * 4.0
	if rotation_ >= 180.0:
		if activate_action != '':
			GameState.available_activators.push_back(activate_action)
		queue_free()


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	build_sound_arrays()
	position = Vector2(randf() * 1600.0, randf() * 50.0 + 700.0)
	texture_left_button.visible = false
	texture_right_button.visible = false
	if position.x + texture_right.get_width() > 1600.0:
		texture_right_node.visible = false
		pivot_scale.scale.x = -1
		used_texture_node = texture_left_node
		if minigame != '':
			texture_left_button.visible = true
		if sounds_left and len(sounds_left) > 0:
			Audio.spawn_sound_effect(
				'SFX',
				sounds_left[randi() % len(sounds_left)]
			)
	else:
		texture_left_node.visible = false
		used_texture_node = texture_right_node
		if minigame != '':
			texture_right_button.visible = true
		if sounds_right and len(sounds_right) > 0:
			Audio.spawn_sound_effect(
				'SFX',
				sounds_right[randi() % len(sounds_right)]
			)
	pivot_rotation.rotation_degrees = 180
	used_texture_node.modulate.a = 0.0
	
	var modulation := 1.0 if minigame != '' else 0.6
	used_texture_node.modulate = Color(modulation, modulation, modulation, 1.0)
	
	if minigame == '':
		return
	#var activator = ACTIVATORS[randi() % len(ACTIVATORS)]
	#activate_action = activator.action
	activate_action = GameState.available_activators.pop_at(randi() % len(GameState.available_activators))
	var activator_texture = ACTIVATORS[activate_action]
	texture_right_button.texture = activator_texture
	texture_left_button.texture = activator_texture


func generate():
	if not Engine.is_editor_hint():
		return
	texture_right_button.visible = minigame != ''
	texture_left_button.visible = minigame != ''
	texture_right_node.texture = texture_right
	texture_left_node.texture = texture_left


func build_sound_arrays():
	if sound_left_1:
		sounds_left.append(sound_left_1)
	if sound_left_2:
		sounds_left.append(sound_left_2)
	if sound_left_3:
		sounds_left.append(sound_left_3)
	if sound_left_4:
		sounds_left.append(sound_left_4)
	if sound_left_5:
		sounds_left.append(sound_left_5)
	if sound_right_1:
		sounds_right.append(sound_right_1)
	if sound_right_2:
		sounds_right.append(sound_right_2)
	if sound_right_3:
		sounds_right.append(sound_right_3)
	if sound_right_4:
		sounds_right.append(sound_right_4)
	if sound_right_5:
		sounds_right.append(sound_right_5)
