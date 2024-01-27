extends Control


const SUCCESSFUL_SPRITES = [
	preload('res://textures/mini_games/dance/dance1.png'),
	preload('res://textures/mini_games/dance/dance3.png'),
	preload('res://textures/mini_games/dance/dance2.png'),
	preload('res://textures/mini_games/dance/dance4.png'),
]

const FAILED_SPRITES = [
	preload('res://textures/mini_games/dance/dance5.png'),
	preload('res://textures/mini_games/dance/dance7.png'),
	preload('res://textures/mini_games/dance/dance6.png'),
	preload('res://textures/mini_games/dance/dance8.png'),
]


var cooldown_after := 2.0


var state := 'started'
var score := -1.0

var arrow_timeout := 0.4

var sequence_full_length := 10
var sequence_length := sequence_full_length


@onready var lanes := [
	get_node('game/lane1') as Control,
	get_node('game/lane2') as Control,
	get_node('game/lane3') as Control,
	get_node('game/lane4') as Control,
]

var lane_buttons = [
	'mg_up',
	'mg_left',
	'mg_down',
	'mg_right',
]


var arrows_per_lane = [[], [], [], []]
var lane_cooldown = [0.0, 0.0, 0.0, 0.0]


func get_lane_arrow_texture(lane: int) -> Texture:
	match lane:
		0:
			return preload("res://textures/mini_games/dance/arrow_up.png")
		1:
			return preload("res://textures/mini_games/dance/arrow_left.png")
		2:
			return preload("res://textures/mini_games/dance/arrow_down.png")
	return preload("res://textures/mini_games/dance/arrow_right.png")


func _physics_process(delta: float) -> void:
	if state != 'going':
		return
	
	for i in range(len(lanes)):
		if lane_cooldown[i] > 0.0:
			lane_cooldown[i] -= delta
			if lane_cooldown[i] <= 0.0:
				lanes[i].get_node('target').modulate = Color(1.0, 1.0, 1.0, 1.0)
			continue
		
		if Input.is_action_just_pressed(lane_buttons[i]):
			var hit := false
			for arrow in arrows_per_lane[i]:
				if not is_instance_valid(arrow):
					continue
				if Box.collides(lanes[i].get_node('target/box'), arrow.get_node('box')):
					arrow.queue_free()
					hit = true
					score += 2.0 * (1.0/float(sequence_full_length))
					break
			if not hit:
				lane_cooldown[i] = 1.0
				lanes[i].get_node('target').modulate = Color(0.5, 0.5, 0.5, 1.0)
				get_node('game/mouse').texture = FAILED_SPRITES[i]
			else:
				get_node('game/mouse').texture = SUCCESSFUL_SPRITES[i]
	
	for i in range(len(arrows_per_lane)):
		var arrows = arrows_per_lane[i]
		for arrow in arrows:
			if is_instance_valid(arrow) and Box.collides(arrow, lanes[i].get_node('target/box')):
				arrow.modulate = Color(1.0, 0.0, 0.0, 1.0)
	
	arrow_timeout -= delta
	if arrow_timeout > 0.0:
		return
	
	if sequence_length <= 0:
		cooldown_after -= delta
		if cooldown_after <= 0:
			state = 'won' if score > 0 else 'lost'
		return
	
	sequence_length -= 1
	
	arrow_timeout += 0.4
	var lane_index := randi() % len(lanes)
	var lane := lanes[lane_index] as Control
	var new_arrow = preload("res://scenes/mini_games/dance/command.tscn").instantiate()
	new_arrow.position.x = lane.size.x
	new_arrow.texture = get_lane_arrow_texture(lane_index)
	lane.add_child(new_arrow)
	arrows_per_lane[lane_index].append(new_arrow)
