extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var q = 0
var r = 0

var contents = []
var controller = "player"

# Called when the node enters the scene tree for the first time.
func _ready():
	reposition()

func reposition():
	Constants.set_coordinates(q, r, self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
