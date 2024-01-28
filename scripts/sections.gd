extends Node


var SECTIONS := {
	's0': {
		section = preload('res://scenes/sections/section0.tscn').instantiate(),
		next = ['s1'],
	},
	's1': {
		section = preload('res://scenes/sections/section1.tscn').instantiate(),
		next = ['s0','s1','s2','s3','s4','s5','s6','s7','s8','s9'],
	},
	's2': {
		section = preload('res://scenes/sections/section2.tscn').instantiate(),
		next = ['s1','s3','s5'],
	},
	's3': {
		section = preload('res://scenes/sections/section3.tscn').instantiate(),
		next = ['s2','s4','s6'],
	},
	's4': {
		section = preload('res://scenes/sections/section4.tscn').instantiate(),
		next = ['s3','s5','s7'],
	},
	's5': {
		section = preload('res://scenes/sections/section5.tscn').instantiate(),
		next = ['s4','s6','s8'],
	},
	's6': {
		section = preload('res://scenes/sections/section6.tscn').instantiate(),
		next = ['s5','s7','s9'],
	},
	's7': {
		section = preload('res://scenes/sections/section7.tscn').instantiate(),
		next = ['s6','s8','s0'],
	},
	's8': {
		section = preload('res://scenes/sections/section8.tscn').instantiate(),
		next = ['s7','s9','s1'],
	},
	's9': {
		section = preload('res://scenes/sections/section9.tscn').instantiate(),
		next = ['s8','s0','s2'],
	},
}

