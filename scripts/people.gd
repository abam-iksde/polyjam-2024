extends KeepAspect


@onready var texture = get_node('texture') as TextureRect


func on_resized():
	texture.size = Vector2(size.x, size.x/texture.texture.get_width() * texture.texture.get_height())
	texture.position.y = size.y-texture.size.y


func _ready():
	super._ready()
	connect('resized', on_resized)
	on_resized()
