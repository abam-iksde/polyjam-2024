extends Area3D


var texture_run := preload('res://textures/player/run_01.png')
var run_frames := 7
var texture_jump := preload('res://textures/player/jump1.png')
var jump_frames := 4


const POSITION_LIMIT = 1.5
const HIT_COOLDOWN = 1.0
const GRAVITY = 3.0
const JUMP_FORCE = 1.5

@onready var sprite := get_node('sprite') as Sprite3D
@onready var ground_y := position.y
var y_velocity := 0.0

var on_ground := true

var hit_cooldown := 0.0

var animation_frame := 0.0
var score_accumulator := 0.0


func on_area_enter(area: Area3D) -> void:
	if area is Obstacle and hit_cooldown <= 0.0:
		hit_cooldown = HIT_COOLDOWN
		Motion.movement_speed = 0.1


func _ready():
	connect('area_entered', on_area_enter)


func _physics_process(delta: float) -> void:
	delta = Motion.get_delta(delta)
	y_velocity -= delta * GRAVITY
	position.y += y_velocity * delta
	if position.y <= ground_y:
		position.y = ground_y
		y_velocity = 0.0
		if not on_ground:
			animation_frame = 0.0
			sprite.texture = texture_run
			sprite.hframes = run_frames
			sprite.flip_h = false
		on_ground = true
	
	if Input.is_action_just_pressed('jump') and on_ground:
		y_velocity = JUMP_FORCE
		on_ground = false
		animation_frame = 0.0
		sprite.texture = texture_jump
		sprite.hframes = jump_frames
		sprite.flip_h = position.x < 0.0
	
	var movement_input := Input.get_axis('move_left', 'move_right')
	if movement_input != 0.0 and not on_ground:
		sprite.flip_h = movement_input < 0.0
	position.x += movement_input * delta
	if abs(position.x) > POSITION_LIMIT:
		position.x = sign(position.x) * POSITION_LIMIT
		
	hit_cooldown -= delta
	
	Motion.movement_speed = lerp(Motion.movement_speed, Motion.MOVEMENT_MAX_SPEED, delta)
	
	animation_frame += delta * (12.0 if on_ground else 4.0) * (Motion.movement_speed/Motion.MOVEMENT_MAX_SPEED)
	sprite.frame = int(animation_frame) % sprite.hframes
	score_accumulator += delta * Motion.movement_speed * 60.0
	while score_accumulator >= 1.0:
		GameState.score += 1
		score_accumulator -= 1.0
