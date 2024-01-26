extends Node3D


@onready var ground := get_node('ground') as MeshInstance3D

var this_section := 's0'
var next_section := 's1'

var next_obstacles = get_section_obstacles('s1')

var section_progress := 0.0

@onready var ground_material := ground.get_surface_override_material(0) as ShaderMaterial
@onready var obstacles = get_node('obstacles') as Node3D


func setup_textures() -> void:
	ground_material.set_shader_parameter('texture_1', get_section_ground_texture(this_section))
	ground_material.set_shader_parameter('texture_2', get_section_ground_texture(next_section))


func go_next_section() -> void:
	this_section = next_section
	var possible_sections := Sections.SECTIONS[this_section].next as Array
	next_section = possible_sections[randi() % len(possible_sections)]
	section_progress -= 1.0
	setup_textures()
	next_obstacles = get_section_obstacles(next_section)


func _physics_process(delta: float) -> void:
	section_progress += delta * Motion.movement_speed
	if section_progress >= 1.0:
		go_next_section()
	ground_material.set_shader_parameter('uv_shift', section_progress)
	spawn_obstacles()


func _ready() -> void:
	setup_textures()


func get_section_ground_texture(section_name: String) -> Texture:
	return Sections.SECTIONS[section_name].section.get_node('ground').texture


func spawn_obstacles() -> void:
	for i in range(len(next_obstacles)):
		var obstacle = next_obstacles[0]
		if obstacle.position.y > section_progress:
			return
		var obstacle_instance = preload('res://scenes/obstacle.tscn').instantiate()
		obstacle_instance.position.x = obstacle.position.x
		obstacles.add_child(obstacle_instance)
		next_obstacles.pop_front()


func get_section_obstacles(section_name: String) -> Array:
	var result := []
	var obstacles = Sections.SECTIONS[section_name].section.get_node('obstacles').get_children()
	obstacles.sort_custom(func(a, b): return a.position.y > b.position.y)
	for obstacle in obstacles:
		var result_obstacle = {}
		result_obstacle.texture = obstacle.texture
		result_obstacle.position = Vector2((obstacle.position.x-512.0)/512.0 * 4.0, obstacle.position.y/1024.0)
		result_obstacle.size = Vector2(obstacle.get_node('collision').size.x/512.0 * 4, obstacle.get_node('collision').size.y/1024)
		result.append(result_obstacle)
	return result
