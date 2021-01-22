extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready():
	var fleet_resource = load("res://scenes/fleet/fleet.tscn")
	var fleet1 = fleet_resource.instance()
	var fleet2 = fleet_resource.instance()
	var ship_resource = load("res://scenes/ship/ship.tscn")
	var ship1 = ship_resource.instance()
	var ship2 = ship_resource.instance()
	var ship3 = ship_resource.instance()
	var ship4 = ship_resource.instance()
	var ship5 = ship_resource.instance()
	var ship6 = ship_resource.instance()
	ship3.ship_type = "cruiser"
	ship2.ship_type = "battleship"
	ship3.speed = 1
	ship2.speed = 1
	fleet1.q = 1
	fleet1.r = 1
	fleet1.add_ship(ship1)
	fleet1.add_ship(ship2)
	fleet1.add_ship(ship3)
	fleet2.q = 1
	fleet2.r = 1
	fleet2.add_ship(ship4)
	fleet2.add_ship(ship5)
	fleet2.add_ship(ship6)
	DataStore.fleets.append(fleet1)
	$galaxy_map.add_child(fleet1)
	DataStore.fleets.append(fleet2)
	$galaxy_map.add_child(fleet2)

