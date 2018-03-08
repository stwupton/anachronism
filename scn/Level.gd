extends Node2D

signal restart

var police_scene = load("res://scn/PoliceCar.tscn")
onready var player = $Player
onready var camera = $Player/Camera2D
onready var police_navigation = $Navigation2D
onready var police_spawns = $PoliceSpawns
onready var pedestrians_list = $PedestriansList

var coffeesDrank = 0
var police_on_the_scene = Array()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player.connect("coffee_collected", self, "_score_up")
	print("Established connection")
	
	for pedestrians in pedestrians_list.get_children():
		pedestrians.connect('coffee_stolen', self, '_on_coffee_stolen')
		
func _on_coffee_stolen(pedestrians):
	for p in pedestrians_list.get_children():
		if p == pedestrians: continue
		p.reset_coffee()

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
	police.connect('wasted_player', self, '_on_player_wasted')
	
	for i in range(3):
		var spawn = police_spawns.get_node('Spawn' + str(i + 1))
		if !spawn.is_on_screen():
			police.position = spawn.global_position
			break
	
	add_child(police)
	police_on_the_scene.append(police)
	print("More police called to the scene. Cars: " + str(police_on_the_scene.size()))

func _on_player_wasted():
	emit_signal('restart')