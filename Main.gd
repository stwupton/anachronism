extends Node2D

onready var level = $Level

func _ready():
	level.connect('restart', self, '_on_restart')
	
func _on_restart():
	var level_scn = load('res://scn/Level.tscn')
	level.queue_free()
	
	level = level_scn.instance()
	level.connect('restart', self, '_on_restart')
	add_child(level)
