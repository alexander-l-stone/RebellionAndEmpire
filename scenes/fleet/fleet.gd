extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var q = 0
var r = 0

var contents = {}
var controller = "Rebellion"

# Called when the node enters the scene tree for the first time.
func _ready():
	reposition()

func reposition():
	Constants.set_coordinates(q, r, self)
	
func add_ship(ship):
	if(contents.has(ship.ship_type)):
		contents[ship.ship_type].append(ship)
	else: 
		contents[ship.ship_type] = [ship]

#TODO: Add a remove_ship and get_ship function

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
