extends Node2D

var planet_details_scene = load("res://scenes/planet_details/planet_details.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("doublelclick_hex", self, "open_planet_details")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func open_planet_details(r, q):
	var planet_details = planet_details_scene.instance()
	var planet = null
	if(DataStore.planets.has(Constants.convert_coordinates_to_string(q, r))):
		planet = DataStore.planets[Constants.convert_coordinates_to_string(q, r)]
	var fleets = []
	for fleet in DataStore.fleets:
		if(fleet.q == q and fleet.r == r):
			fleets.append(fleet)
	planet_details.planet = planet
	planet_details.fleets = fleets
	$UI_Camera.add_child(planet_details)
