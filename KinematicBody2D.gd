extends KinematicBody2D



func _ready():
	set_physics_process(true)
	print("This is the brain - reading loud and clear..!")

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_slide(Vector2(-50, 0))
	if Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(50, 0))
	if Input.is_action_pressed("ui_up"):
		move_and_slide(Vector2(0, -50))
	if Input.is_action_pressed("ui_down"):
		move_and_slide(Vector2(0, 50))

# If left is pressed 
#   move and slide character left 

