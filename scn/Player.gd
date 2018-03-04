extends KinematicBody2D

signal coffee_collected

onready var handsArea = $CoffeeStealer
onready var hands = $CoffeeStealer/InteractionTrigger

#Variables declared to make the game work... 
#It just works... (tm)
var movementVariable = Vector2(0,0)

var coffeesCollected = 0

func _ready(): #As soon as the object is put into the game... run this:
	set_physics_process(true) #Look out for _physics_process(delta)
	print("This is the player brain - reading loud and clear..!")
	handsArea.connect("area_entered", self, "_on_area_entered") #prepares to take coffees

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
	movementVariable = movementVariable.normalized()
	move_and_slide(movementVariable*500)

func _on_area_entered(area):
	if area.name == "CoffeeToTakeArea":
		emit_signal("coffee_collected")


		
#If (our character) touches (someone (who has a coffee))
	#Remove the coffee from the person
	#Add to a counter to show we have drank the coffee! 