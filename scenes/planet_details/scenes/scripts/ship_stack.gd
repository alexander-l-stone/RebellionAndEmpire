extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fleet = null

var ship_type = "destroyer"

var ship_number = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_self()

func draw_self():
	$Ship_Sprite.texture = load("res://resources/" + ship_type + ".png")
	$NumShips_Label.text = "x" + str(ship_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
