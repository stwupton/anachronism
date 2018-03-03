extends KinematicBody2D

var movementVariable = Vector2(0,0)

func _ready():
	set_physics_process(true)
	print("This is the brain - reading loud and clear..!")

func _physics_process(delta):
	movementVariable = Vector2(0,0)
	if Input.is_action_pressed("ui_left"):
		movementVariable.x-=1
	if Input.is_action_pressed("ui_right"):
		movementVariable.x+=1
	if Input.is_action_pressed("ui_up"):
		movementVariable.y-=1
	if Input.is_action_pressed("ui_down"):
		movementVariable.y+=1
	movementVariable.normalized()
	move_and_slide(movementVariable*350)
