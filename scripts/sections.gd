extends Node


var SECTIONS := {
	's0': {
		section = preload('res://scenes/sections/section0.tscn').instantiate(),
		next = ['s1'],
	},
	's1': {
		section = preload('res://scenes/sections/section1.tscn').instantiate(),
		next = ['s0'],
	},
}
