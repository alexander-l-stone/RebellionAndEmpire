extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var rtl_coordinates = self.get_node("UI_CanvasLayer/RTL_Coordinates")
	SignalManager.connect('hover_coordinates', rtl_coordinates, 'display')
	SignalManager.connect('clear_coordinates', rtl_coordinates, 'clear')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
