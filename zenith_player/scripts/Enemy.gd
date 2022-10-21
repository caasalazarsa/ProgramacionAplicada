extends KinematicBody2D

export var walk_velocity=50
export var run_velocity=100

var total_velocity = Vector2(0,0)

var state=1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	match state:
		1:
			quieto()
		2:
			caminata()
		3:
			sprint()
	
	pass
	

func _physics_process(delta):
	move_and_slide(total_velocity)

func quieto():
	total_velocity.x=0
	total_velocity.y=0
	print("estoy quieto")
	
	if(Input.is_action_pressed("ui_up")or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") ):
		state=2
	
	pass

func caminata():
	
	moverse(walk_velocity)
	
	if Input.is_action_pressed("ui_up"):
		print("camino al norte")
	if Input.is_action_pressed("ui_down"):
		print("camino al sur")
	if Input.is_action_pressed("ui_right"):
		print("camino al este")
	if Input.is_action_pressed("ui_left"):
		print("camino al oeste")
		
	if(!Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right") ):
		state=1
		
	if(Input.is_action_pressed("ui_cancel") ):
		state=3
	
	pass

func sprint():
	
	moverse(run_velocity)
	
	if Input.is_action_pressed("ui_up"):
		print("corro al norte")
	if Input.is_action_pressed("ui_down"):
		print("corro al sur")
	if Input.is_action_pressed("ui_right"):
		print("corro al este")
	if Input.is_action_pressed("ui_left"):
		print("corro al oeste")
		
	if(!Input.is_action_pressed("ui_cancel") ):
		state=2
	
	pass
	
func moverse(input_velocity):
	total_velocity.x=(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")))*input_velocity
	total_velocity.y=(int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up")))*input_velocity
