extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal lose_life
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pit_body_entered(body):
	if body.is_in_group("player"):
		#print("se cayó")
		emit_signal("lose_life")
	pass # Replace with function body.
