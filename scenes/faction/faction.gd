extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var faction_name := "Rebellion"
export var faction_color := Color(0, 0, 1)
export var faction_flag_path := ""

var player_controlled := false

var planets = []
var fleets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
