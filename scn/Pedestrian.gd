tool
extends Node2D

export(bool) var has_coffee = false setget _set_has_coffee

onready var coffee_area = $CoffeeToTakeArea #get_node('Coffee/Area2D')
onready var animation_player = $AnimationPlayer
onready var person = $Person

func _ready():
	_set_has_coffee(has_coffee)
	animation_player.play('Shuffle')
	
func _on_area_entered(area):
	if area.name == 'CoffeeStealer':
		_set_has_coffee(false)
		
func _set_has_coffee(x):
	has_coffee = x
	
	if person != null && coffee_area != null:
		person.play('coffee' if has_coffee else 'non_coffee')
	
		if has_coffee:
			coffee_area.monitorable = true
			coffee_area.connect('area_entered', self, '_on_area_entered')
		else:
			coffee_area.monitorable = false
			coffee_area.disconnect('area_entered', self, '_on_area_entered')
