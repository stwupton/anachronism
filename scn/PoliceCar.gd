extends KinematicBody2D

export(NodePath) var navigation_path
export(NodePath) var target_path

onready var navigation = get_node(navigation_path)
onready var target = get_node(target_path)

var current_path = []

var _motion = Vector2()
var _friction = 10
var _horse_power = 40
var _max_speed = 600

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	current_path = navigation.get_simple_path(global_position, target.global_position)
	
	var direction = (current_path[1] - current_path[0]).normalized()
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
	
	