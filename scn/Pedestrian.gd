extends Node2D

onready var coffee_area = $Coffee/CoffeeToTakeArea #get_node('Coffee/Area2D')
onready var coffee = $Coffee

func _ready():
	coffee_area.connect('area_entered', self, '_on_area_entered')
	
func _on_area_entered(area):
	if area.name == 'CoffeeStealer':
		coffee.queue_free()
