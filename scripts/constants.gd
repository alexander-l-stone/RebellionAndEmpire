extends Node

const hex_width = 64
const hex_height = 64


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_coordinates(q, r, node):
	node.set_global_position(Vector2(Constants.hex_height*r*sin(deg2rad(60)),Constants.hex_width*q+cos(deg2rad(60))*r*Constants.hex_height))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
