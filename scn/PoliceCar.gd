extends KinematicBody2D

export(NodePath) var navigation_path
export(NodePath) var target_path

onready var navigation = get_node(navigation_path)
onready var target = get_node(target_path)

var _current_path = []
var _motion = Vector2()
var _friction = 10
var _horse_power = 40
var _max_speed = 600

func _draw():
	for i in range(_current_path.size() - 1):
		draw_line(_current_path[i] - global_position, _current_path[i + 1] - global_position, Color(100, 0, 0), 3)

func _ready():
	set_process(true)
	set_physics_process(true)
	
func _process(delta):
	update()
	
func _physics_process(delta):
	_current_path = navigation.get_simple_path(global_position, target.global_position, false)
	
	var direction = (_current_path[1] - _current_path[0]).normalized()
	_motion += direction * _horse_power

	# Apply friction
	if abs(_motion.x) < _friction: _motion.x = 0
	else: _motion.x -= _friction * (1 if _motion.x > 0 else -1)
		
	if abs(_motion.y) < _friction: _motion.y = 0
	else: _motion.y -= _friction * (1 if _motion.x > 0 else -1)
	
	_motion.x = clamp(_motion.x, -_max_speed, _max_speed)
	_motion.y = clamp(_motion.y, -_max_speed, _max_speed)
	
	var motion_direction = Vector2(_motion.x, _motion.y).normalized()
	var angle_deg = -rad2deg(atan2(motion_direction.x, motion_direction.y))
	rotation_degrees = angle_deg
	
	_motion = move_and_slide(_motion)
	
	