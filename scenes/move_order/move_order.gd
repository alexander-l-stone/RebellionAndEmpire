extends Node2D

class_name MoveOrder

#target are dicts of the form {'q': int, 'r': int}
var target
var issuing_fleet
var travel_path = []


# Called when the node enters the scene tree for the first time.
func _ready():
	Constants.set_coordinates(target['q'], target['r'], $MoveOrder_Sprite)

func process_order():
	#if next_order != null do the todo below
	for node in travel_path:
		issuing_fleet.q = node['q']
		issuing_fleet.r = node['r']
		print("Fleet Q: " + str(issuing_fleet.q) + ', Fleet R: ' + str(issuing_fleet.r))
		issuing_fleet.reposition()
		#TODO: Break if there is an enemy here
	if(issuing_fleet.q == target['q'] and issuing_fleet.r == target['r']):
		return true
	return false
