tool
extends Node2D

export(bool) var has_coffee = false setget _set_has_coffee

onready var coffee_area = $Coffee/CoffeeToTakeArea #get_node('Coffee/Area2D')
onready var coffee = $Coffee
onready var animation_player = $AnimationPlayer

func _ready():
	_set_has_coffee(has_coffee)
	animation_player.play('Shuffle')
	
func _on_area_entered(area):
	if area.name == 'CoffeeStealer':
		coffee.queue_free()
		has_coffee = false
		
func _set_has_coffee(x):
	has_coffee = x
	
	if coffee != null && coffee_area != null:
		coffee.visible = has_coffee
	
		if has_coffee:
			coffee_area.connect('area_entered', self, '_on_area_entered')
		else:
			coffee_area.disconnect('area_entered', self, '_on_area_entered')
