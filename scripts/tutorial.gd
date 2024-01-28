extends Node


var ui


var roadmap = ConfigFile.new()


func _ready():
	roadmap.load('tutorial.ini')


func discover(what: String, where=null) -> void:
	var previously_discovered = roadmap.get_value('tutorial', what, false) as bool
	#var previously_discovered = false
	if previously_discovered:
		return
	roadmap.set_value('tutorial', what, true)
	roadmap.save('tutorial.ini')
	if ui:
		ui.show_tutorial_page(what, where)
