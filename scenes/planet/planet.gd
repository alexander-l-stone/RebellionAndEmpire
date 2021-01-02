extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var q = 0
var r = 0

var planet_type = "barren_planet"
var planet_name = "Barren Planet"

var planetary_buildings = []
var orbital_buildings = []
var garrison = {}
var special_units = {}
var planetary_building_slots = 2
var orbital_building_slots = 2
var special = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	reposition()

func reposition():
	Constants.set_coordinates(q, r, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
