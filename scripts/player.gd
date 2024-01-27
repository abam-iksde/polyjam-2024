extends Area3D


const POSITION_LIMIT = 2.0
const HIT_COOLDOWN = 1.0
const GRAVITY = 3.0
const JUMP_FORCE = 1.5

@onready var sprite := get_node('sprite') as Sprite3D
@onready var ground_y := position.y
var y_velocity := 0.0

var on_ground := true

var hit_cooldown := 0.0

var animation_frame := 0.0


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
		on_ground = true
	
	if Input.is_action_just_pressed('jump') and on_ground:
		y_velocity = JUMP_FORCE
		on_ground = false
	
	var movement_input := Input.get_axis('move_left', 'move_right')
	position.x += movement_input * delta
	if abs(position.x) > POSITION_LIMIT:
		position.x = sign(position.x) * POSITION_LIMIT
		
	hit_cooldown -= delta
	
	Motion.movement_speed = lerp(Motion.movement_speed, 0.3, delta)
	
	animation_frame += delta * 12.0 * (Motion.movement_speed/0.3)
	sprite.frame = int(animation_frame) % sprite.hframes
