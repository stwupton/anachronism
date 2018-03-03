extends KinematicBody2D

#Variables declared to make the game work... 
#It just works... (tm)
var movementVariable = Vector2(0,0)

func _ready(): #As soon as the object is put into the game... run this:
	set_physics_process(true) #Look out for _physics_process(delta)
	print("This is the brain - reading loud and clear..!")

func _physics_process(delta): #Gets checked every physics check 
	#Movement via keys 
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
	
	#Checking if we have touched coffee!
	# get_node("InteractionTrigger"):
	#	pass
		
#If (our character) touches (someone (who has a coffee))
	#Remove the coffee from the person
	#Add to a counter to show we have drank the coffee! 