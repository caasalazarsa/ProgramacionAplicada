extends KinematicBody2D


var state =1

var gravity=100

var walk_time_start=0
var walk_time_now=0
var walk_flag=false
export var walk_velocity=100
export var run_velocity=400
export var jump_speed=300

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
			caminar()
		3:
			correr()
		4:	
			saltar()
			
	
	pass
	
func _physics_process(delta):
	move_and_slide(velocity,Vector2(1,0))

func quieto():
	print("estoy quieto")
	if(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		state=2	
		
	if(Input.is_action_just_pressed("ui_accept")):
		state=4
		
		
	pass
	
func caminar():
	walk_time_now=OS.get_unix_time()
	
	velocity.x=(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")))*walk_velocity
	
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
		
	if(Input.is_action_just_pressed("ui_accept")):
		state=4
		
	pass
	
func correr():
	
	velocity.x=(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")))*run_velocity
	
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
		
	if(Input.is_action_just_pressed("ui_accept")):
		state=4
	
	pass	
	
func saltar():
	velocity.y=velocity.y-jump_speed
	pass

func gravity_effect(delta):
	if velocity.y<400:
		velocity.y=velocity.y+gravity*delta
	
	

	
