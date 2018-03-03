extends Node2D

export(Array, NodePath) var police_paths = []

onready var police = []

func _draw():
	for popo in police:
		var path = popo.current_path
		for i in range(path.size() - 1):
			draw_line(path[i], path[i + 1], Color(100, 0, 0), 3)

func _ready():
	for path in police_paths:
		police.append(get_node(path))
	
	set_process(true)
	
func _process(delta):
	update()