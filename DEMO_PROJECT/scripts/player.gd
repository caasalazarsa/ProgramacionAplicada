extends KinematicBody2D

# variable de control máquina de estados
var state =1

# en el caso de los kinematic body se debe añadir el efecto gravitatorio
# ya que el juego demo es un plataformero
var gravity=500

# velocidades de movimiento horizontal jump_velocity se asigna de acuerdo al
# estado desde el cual se hace el salto
export var walk_velocity=300
export var run_velocity=600
export var jump_velocity=0

# velocidad de salto vertical
export var jump_speed=400

# vector en el cual se suman todas las velocidades
var velocity=Vector2(0,0)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animation_sprite = get_node("Animations")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# efecto gravitatorio continuo
	gravity_effect(delta)
	
	# máquina de estados	
	match state:
		1:
			quieto()
		2:
			caminata()
		3:
			sprint()
		4:	
			salto()
			
	_animate()
	
	pass
	
func _physics_process(delta):
	# con esta función el cuerpo puede moverse, colisionar y deslizarse sobre las plataformas
	# el segundo parametro determina la normal de las superficies, es decir, la dirección en la
	# perpendicular al suelo
	move_and_slide(velocity,Vector2(0,-1))
	
	
func _animate():
	if state==1:
		animation_sprite.play("Quieto")
	if state==2 or 3:
		if state==3:
			animation_sprite.get_sprite_frames().set_animation_speed("Derecha", 10)
		else:
			animation_sprite.get_sprite_frames().set_animation_speed("walk", 5)
		if Input.is_action_pressed("ui_left"):
			animation_sprite.flip_h=true
		if Input.is_action_pressed("ui_right"):
			animation_sprite.flip_h=false
		animation_sprite.play("Derecha")
		
	

	## ESTADO QUIETO
	# si se oprime <- o -> el jugador pasara de quieto a caminata
	# si se oprime "ui_accept" el jugador para a salto
	# las convenciones para las entradas están en 
	# Proyecto>Configuración del proyecto>Mapa de entrada
func quieto():
	print("estoy quieto")
	velocity.x=0
	if(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		state=2	
		
	if(Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		jump_velocity=walk_velocity
		state=4
		velocity.y=velocity.y-jump_speed
		
		
		
	pass
	
	## ESTADO CAMINATA
	# en este estado el jugador podrá moverse a la velocidad de caminata,
	# hacer un salto si se oprime accept
	# empezar a correr si se oprime cancel
	
	
func caminata():
	
	moverse(walk_velocity)
	
	if(Input.is_action_pressed("ui_right")):
		#$Sprite.flip_h=false
		print("camino hacia la derecha")
	if(Input.is_action_pressed("ui_left")):
		#$Sprite.flip_h=true
		print("camino hacia la izquierda")	
	
	if(!Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right")):
		state=1
	if(Input.is_action_pressed("ui_cancel")):
		state=3
		
	if(Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		jump_velocity=walk_velocity
		state=4
		velocity.y=velocity.y-jump_speed
		
	pass
	
	## ESTADO SPRINT
	# en este estado el jugador podrá moverse a la velocidad de sprint,
	# hacer un salto si se oprime accept
	# empezar a caminar si se suelta el botón cancel
	
	
func sprint():
	
	moverse(run_velocity)
	if(Input.is_action_pressed("ui_right")):
		#$Sprite.flip_h=false
		print("corro hacia la derecha")
	if(Input.is_action_pressed("ui_left")):
		#$Sprite.flip_h=true
		print("corro hacia la izquierda")
	if(!Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right")):
		state=1
	if !Input.is_action_pressed("ui_cancel"):
		state=2	
		
	if(Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		jump_velocity=run_velocity
		state=4
		velocity.y=velocity.y-jump_speed
		
	
	pass	
	
	## ESTADO SALTO
	# En este estado el jugador puede moverse a la velocidad de caminata o sprint
	# acorde a la asignación de jump_velocity
	# si toca el piso vuelve al estado quieto
	# la función is on floor trabaja con la normal definida en move_and_slide()
	
	
func salto():
	moverse(jump_velocity)
	print("estoy en el aire")
	if(is_on_floor()):
		state=1
	pass
	
	# efecto gravitatorio en el personaje

func gravity_effect(delta):
	
	if is_on_floor():
		velocity.y=gravity*delta
	
	else:
		if velocity.y <1000:
			velocity.y=velocity.y+gravity*delta
	
		
	# función para moverse
	# importante entender la lógica 
	
func moverse(input_velocity):
	velocity.x=(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")))*input_velocity
	pass
	

	
