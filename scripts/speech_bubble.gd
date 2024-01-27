@tool
extends Control


const ACTIVATORS = [
	{ action = 'mg_activate_1', texture = preload('res://textures/buttons/a.png') },
	{ action = 'mg_activate_2', texture = preload('res://textures/buttons/b.png') },
]


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
		queue_free()


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	position = Vector2(randf() * 1600.0, randf() * 50.0 + 700.0)
	texture_left_button.visible = false
	texture_right_button.visible = false
	if position.x + texture_right.get_width() > 1600.0:
		texture_right_node.visible = false
		pivot_scale.scale.x = -1
		used_texture_node = texture_left_node
		if minigame != '':
			texture_left_button.visible = true
	else:
		texture_left_node.visible = false
		used_texture_node = texture_right_node
		if minigame != '':
			texture_right_button.visible = true
	pivot_rotation.rotation_degrees = 180
	used_texture_node.modulate.a = 0.0
	
	if minigame == '':
		return
	var activator = ACTIVATORS[randi() % len(ACTIVATORS)]
	activate_action = activator.action
	texture_right_button.texture = activator.texture
	texture_left_button.texture = activator.texture


func generate():
	if not Engine.is_editor_hint():
		return
	texture_right_button.visible = minigame != ''
	texture_left_button.visible = minigame != ''
	texture_right_node.texture = texture_right
	texture_left_node.texture = texture_left
