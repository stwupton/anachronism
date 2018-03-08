tool
extends Node2D

signal coffee_stolen

export(bool) var has_coffee = false setget _set_has_coffee

onready var coffee_area = $CoffeeToTakeArea #get_node('Coffee/Area2D')
onready var animation_player = $AnimationPlayer
onready var person = $Person

func _ready():
	_set_has_coffee(has_coffee)
	animation_player.play('Shuffle')
		
func _set_has_coffee(x):
	if x != has_coffee && x == false:
		emit_signal('coffee_stolen')
	
	has_coffee = x
	
	if is_inside_tree():
		person.play('coffee' if has_coffee else 'non_coffee')