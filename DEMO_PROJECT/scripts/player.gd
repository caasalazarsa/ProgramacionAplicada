extends KinematicBody2D


var state =1

var walk_time_start=0
var walk_time_now=0
var walk_flag=false
var walk_velocity=20

var velocity=Vector2(0,0)
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
			caminar()
		3:
			correr()
	
	pass
	
func _physics_process(delta):
	move_and_slide(velocity,Vector2(1,0))

func quieto():
	print("estoy quieto")
	if(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		state=2	
	pass
	
func caminar():
	walk_time_now=OS.get_unix_time()
	
	velocity.x=(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")))*walk_velocity
	
	if(Input.is_action_pressed("ui_right")):
		print("camino hacia la derecha")
	if(Input.is_action_pressed("ui_left")):
		print("camino hacia la izquierda")	
	
	if(Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right")):
		state=1
	if(Input.is_action_pressed("ui_cancel")):
		state=3
		
	pass
	
func correr():
	if(Input.is_action_pressed("ui_right")):
		print("corro hacia la derecha")
	if(Input.is_action_pressed("ui_left")):
		print("corro hacia la izquierda")
	if(Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right")):
		state=1
	pass	
	
