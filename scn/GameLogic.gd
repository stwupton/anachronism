extends Node2D

var police_scene = load("res://scn/PoliceCar.tscn")
onready var player = get_node("Player")
onready var police_navigation = get_node("Navigation2D")

var coffeesDrank = 0
var police_on_the_scene = Array()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player.connect("coffee_collected", self, "_score_up")
	print("Established connection")

func _score_up():
	coffeesDrank = coffeesDrank + 1
	print("Coffee collected. Total: " + str(coffeesDrank))
	_game_progression()

func _game_progression():
	if coffeesDrank == 3:
		_spawn_police_car()
	if coffeesDrank == 10:
		_spawn_police_car()
	if coffeesDrank == 20:  
		_spawn_police_car()

func _spawn_police_car():
	var police = police_scene.instance()
	police.navigation_path = "../Navigation2D"
	police.target_path = "../Player"
	police.scale.x = 0.3
	police.scale.y = 0.3
	add_child(police)
	police_on_the_scene.append(police)
	print("More police called to the scene. Cars: " + str(police_on_the_scene.size()))
