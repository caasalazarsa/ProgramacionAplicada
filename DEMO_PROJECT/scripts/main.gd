extends Node2D

var score=0
var vidas=5
var scoretext="Puntuación: "
var livestext="Vidas: "
var gameover_flag=false

onready var score_label = get_node("CanvasLayer/Puntuacion")
onready var lives_label = get_node("CanvasLayer/Vidas")

onready var game_over_label = get_node("CanvasLayer/GameOverText")
onready var game_over_sprite = get_node("CanvasLayer/GameOverSprite")
onready var player = get_node("animated_player")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	game_over_label.visible=false
	game_over_sprite.visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gameover_flag:
		if(Input.is_action_pressed("ui_accept")):
			get_tree().reload_current_scene()
			pass
	pass


func _on_coin_coin_collected():
	score=score+100
	score_label.clear()
	score_label.add_text(scoretext+String(score))
	pass # Replace with function body.
	



func _on_Pit_lose_life():
	if vidas >0:
		vidas=vidas-1
		lives_label.clear()
		lives_label.add_text(livestext+String(vidas))
	else:
		player.queue_free()
		game_over_label.visible=true
		game_over_sprite.visible=true
		gameover_flag=true
		
	
	pass # Replace with function body.


