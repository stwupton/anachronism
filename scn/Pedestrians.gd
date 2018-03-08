tool
extends Node2D

signal coffee_stolen(pedestrians)

onready var coffee_drinking_pedestrian = $PathFollow2D/Pedestrian

export(NodePath) var follow_path
export(float) var pedestrian_rotation = 0 setget _set_pedestrian_rotation

func _ready():
	set_physics_process(true)
	_set_pedestrian_rotation(pedestrian_rotation)
	coffee_drinking_pedestrian.connect('coffee_stolen', self, '_on_coffee_stolen')
	
func _on_coffee_stolen():
	emit_signal('coffee_stolen', self)
		
func _set_pedestrian_rotation(x):
	pedestrian_rotation = x
	
	if is_inside_tree():
		for child in get_children():
			child.get_node('Pedestrian').rotation_degrees = x
	
func _physics_process(delta):
	for child in get_children():
		child.set_offset(child.get_offset() + 300 * delta)
		
func reset_coffee():
	coffee_drinking_pedestrian.has_coffee = true
		
