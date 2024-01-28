extends KeepAspectControl


@export var world_path: NodePath


var page


func _ready():
	super._ready()
	Tutorial.ui = self


func show_tutorial_page(on: String, where=null):
	page = get_node_or_null(on)
	if not page:
		return
	page.visible = true
	get_tree().paused = true


func _physics_process(delta):
	if not page:
		return
	if Input.is_action_just_pressed("ui_accept"):
		page.visible = false
		page = null
		get_tree().paused = false
