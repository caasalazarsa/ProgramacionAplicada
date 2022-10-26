extends Node2D

var score=0
var scoretext="Puntuación: "

onready var score_label = get_node("CanvasLayer/Puntuacion")

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
