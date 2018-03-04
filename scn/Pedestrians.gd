extends Node2D

export(NodePath) var follow_path

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	for child in get_children():
		child.set_offset(child.get_offset() + 300 * delta)
		
