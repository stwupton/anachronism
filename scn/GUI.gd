extends Control

onready var _score = $Score

var _s = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func increment_score():
	_s += 1
	_score.text = str(_s)