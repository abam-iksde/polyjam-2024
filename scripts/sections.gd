extends Node


var SECTIONS := {
	's0': {
		section = preload('res://scenes/sections/section0.tscn').instantiate(),
		next = ['s0'],
	},
	's1': {
		section = preload('res://scenes/sections/section1.tscn').instantiate(),
		next = ['s0'],
	},
	's2': {
		section = preload('res://scenes/sections/section2.tscn').instantiate(),
		next = ['s1','s0','s2'],
	},
}

