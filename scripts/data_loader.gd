extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_data(path):
	var file = File.new()
	file.open("res://data/" + path, file.READ)
	var json_text = file.get_as_text()
	var json_dict = JSON.parse(json_text)
	file.close()
	return json_dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass-

