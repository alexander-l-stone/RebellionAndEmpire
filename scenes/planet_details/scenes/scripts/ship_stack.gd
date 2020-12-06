extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fleet = null

var ship_type = "destroyer"

var ship_number = 1

var index = 0

var mouse_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_self()

func draw_self():
	$Ship_Sprite.texture = load("res://resources/" + ship_type + ".png")
	$NumShips_Label.text = "x" + str(ship_number)

func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		if(mouse_inside):
			print('Mouse Click: ' + str(self))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ShipStack_mouse_entered():
	self.mouse_inside = true


func _on_ShipStack_mouse_exited():
	self.mouse_inside = false
