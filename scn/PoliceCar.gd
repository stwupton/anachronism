extends KinematicBody2D

export(NodePath) var navigation_path
export(NodePath) var target_path

onready var navigation = get_node(navigation_path)
onready var target = get_node(target_path)

var current_path = []

var _turning_speed = 120
var _motion = Vector2()
var _friction = 20
var _horse_power = 40
var _max_speed = 400

func _ready():
	set_physics_process(true)
	
func _get_angle_direction(from, to):
	var angle_scalar
	if abs(from - to) < 180:
		angle_scalar = 1 if from < to else -1
	elif from == to:
		angle_scalar = 0
	else:
		angle_scalar = -1 if from < to else 1
	return angle_scalar
	
func _physics_process(delta):
	current_path = navigation.get_simple_path(global_position, target.global_position)
	
	# Apply friction
	if abs(_motion.x) < _friction: _motion.x = 0
	else: _motion.x -= _friction * (1 if _motion.x > 0 else -1)
		
	if abs(_motion.y) < _friction: _motion.y = 0
	else: _motion.y -= _friction * (1 if _motion.y > 0 else -1)
	
	# Move in forward direction
	_motion += -global_transform.y.normalized() * _horse_power
	
	# Apply rotation
	var to_direction = (current_path[1] - current_path[0]).normalized()
	var to_angle = rad2deg(atan2(to_direction.x, to_direction.y))
	var current_direction = global_transform.y.normalized()
	var current_angle = rad2deg(atan2(current_direction.x, current_direction.y))
	var angle_scalar = _get_angle_direction(current_angle, to_angle)
	
	var rotate_by = _turning_speed * angle_scalar * delta
	rotation_degrees += rotate_by
	
	_motion.x = clamp(_motion.x, -_max_speed, _max_speed)
	_motion.y = clamp(_motion.y, -_max_speed, _max_speed)
	
	_motion = move_and_slide(_motion)
	
	