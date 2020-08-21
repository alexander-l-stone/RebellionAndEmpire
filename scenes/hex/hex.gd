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

func _on_Hex_mouse_entered():
	$Sprite_Hex.modulate = Color(min(0, red-0.1), min(0, green-0.1), min(0, blue-0.1))


func _on_Hex_mouse_exited():
	$Sprite_Hex.modulate = Color(red, green, blue)
