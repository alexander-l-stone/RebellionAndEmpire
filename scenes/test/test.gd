extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready():
	var fleet_resource = load("res://scenes/fleet/fleet.tscn")
	var fleet = fleet_resource.instance()
	var ship_resource = load("res://scenes/ship/ship.tscn")
	var ship1 = ship_resource.instance()
	var ship2 = ship_resource.instance()
	var ship3 = ship_resource.instance()
	ship3.ship_type = "cruiser"
	ship2.ship_type = "battleship"
	fleet.q = 1
	fleet.r = 1
	fleet.add_ship(ship1)
	fleet.add_ship(ship2)
	fleet.add_ship(ship3)
	DataStore.fleets.append(fleet)
	$galaxy_map.add_child(fleet)
