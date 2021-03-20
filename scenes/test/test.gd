extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready():
	var fleet_resource = load("res://scenes/fleet/fleet.tscn")
	var fleet1 = fleet_resource.instance()
	var fleet2 = fleet_resource.instance()
	fleet1.q = 1
	fleet1.r = 1
	fleet2.q = 1
	fleet2.r = 1
	fleet2.fleet_speed = 2
	DataStore.fleets.append(fleet1)
	$galaxy_map.add_child(fleet1)
	DataStore.fleets.append(fleet2)
	$galaxy_map.add_child(fleet2)

