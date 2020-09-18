extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var fleet_resource = load("res://scenes/fleet/fleet.tscn")
	var fleet = fleet_resource.instance()
	fleet.q = 1
	fleet.r = 1
	DataStore.fleets[str(fleet.q) + str(fleet.r)] = fleet
	$galaxy_map.add_child(fleet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
