extends Node

# Use values from 0 to 1
export var red = 0.0
export var green = 0.0
export var blue = 0.0

export var q = 0
export var r = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite_Hex.modulate = Color(red, green, blue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
