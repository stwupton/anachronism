tool
extends Node2D

export(NodePath) var follow_path
export(float) var pedestrian_rotation = 0 setget _set_pedestrian_rotation

func _ready():
	set_physics_process(true)
	_set_pedestrian_rotation(pedestrian_rotation)
		
func _set_pedestrian_rotation(x):
	pedestrian_rotation = x
	
	if is_inside_tree():
		for child in get_children():
			child.get_node('Pedestrian').rotation_degrees = x
	
func _physics_process(delta):
	for child in get_children():
		child.set_offset(child.get_offset() + 300 * delta)
		
