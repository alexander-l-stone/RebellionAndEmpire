extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitGame_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_NewGame_pressed():
	#TODO: Move to a scenario select screen
	get_tree().change_scene("res://scenes/test/test.tscn")
	pass # Replace with function body.
