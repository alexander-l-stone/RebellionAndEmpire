extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sector_types = {}
var planet_types = {
	"asteroid_field": {
		"sprite_name": "asteroid_field",
		"building_slots": 1,
		"special": {
			"cloaked_all": true,
		},
	},
	"barren_planet":
		{
			"sprite_name": "habitable_planet",
			"building_slots": 2,
			"special": {},
		},
	"habitable_planet": 
		{
			"sprite_name": "habitable_planet",
			"building_slots": 4,
			"special": {},
		},
}

var planets = {}
var fleets = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var sectors_json = DataLoader.load_data("/core/sectors.json")
	self.sector_types = sectors_json.result


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
