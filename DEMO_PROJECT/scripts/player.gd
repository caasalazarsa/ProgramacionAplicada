extends KinematicBody2D


var state =1

var gravity=400

var walk_time_start=0
var walk_time_now=0
var walk_flag=false
export var walk_velocity=100
export var run_velocity=400
export var jump_velocity=0
export var jump_speed=600

var velocity=Vector2(0,0)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	gravity_effect(delta)
	
	match state:
		1:
			quieto()
		2:
			caminata()
		3:
			sprint()
		4:	
			salto()
			
	
	pass
	
func _physics_process(delta):
	move_and_slide(velocity,Vector2(0,-1))

func quieto():
	print("estoy quieto")
	if(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		state=2	
		
	if(Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		jump_velocity=walk_velocity
		state=4
		velocity.y=velocity.y-jump_speed
		
		
		
	pass
	
func caminata():
	walk_time_now=OS.get_unix_time()
	
	moverse(walk_velocity)
	
	if(Input.is_action_pressed("ui_right")):
		$Sprite.flip_h=false
		print("camino hacia la derecha")
	if(Input.is_action_pressed("ui_left")):
		$Sprite.flip_h=true
		print("camino hacia la izquierda")	
	
	if(Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right")):
		state=1
	if(Input.is_action_pressed("ui_cancel")):
		state=3
		
	if(Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		jump_velocity=walk_velocity
		state=4
		velocity.y=velocity.y-jump_speed
		
	pass
	
func sprint():
	
	moverse(run_velocity)
	if(Input.is_action_pressed("ui_right")):
		$Sprite.flip_h=false
		print("corro hacia la derecha")
	if(Input.is_action_pressed("ui_left")):
		$Sprite.flip_h=true
		print("corro hacia la izquierda")
	if(Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right")):
		state=1
	if Input.is_action_just_released("ui_cancel"):
		state=2	
		
	if(Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		jump_velocity=run_velocity
		state=4
		velocity.y=velocity.y-jump_speed
		
	
	pass	
	
func salto():
	moverse(jump_velocity)
	print("estoy en el aire")
	if(is_on_floor()):
		state=1
	pass

func gravity_effect(delta):
	if velocity.y<400:
		velocity.y=velocity.y+gravity*delta
	
func moverse(input_velocity):
	velocity.x=(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")))*input_velocity
	pass
	

	
