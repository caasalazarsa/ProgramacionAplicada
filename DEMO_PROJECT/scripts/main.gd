extends Node2D

var score=0
var vidas=5
var scoretext="Puntuación: "
var livestext="Vidas: "

onready var score_label = get_node("CanvasLayer/Puntuacion")
onready var lives_label = get_node("CanvasLayer/Vidas")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_coin_coin_collected():
	score=score+100
	score_label.clear()
	score_label.add_text(scoretext+String(score))
	pass # Replace with function body.
	



func _on_Pit_lose_life():
	vidas=vidas-1
	lives_label.clear()
	lives_label.add_text(livestext+String(vidas))

	pass # Replace with function body.


