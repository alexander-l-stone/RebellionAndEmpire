extends Node2D


#target are dicts of the form {'q': int, 'r': int}
var target
var issuing_fleet
var nodes_to_visit: Array

class_name MoveOrder

# Called when the node enters the scene tree for the first time.
func _ready():
	Constants.set_coordinates(target['q'], target['r'], $MoveOrder_Sprite)

func process_order():
	#if next_order != null do the todo below
	for node in self.nodes_to_vist:
		issuing_fleet.q = node['q']
		issuing_fleet.r = node['r']
		#TODO: Break if there is an enemy here
	if(issuing_fleet.q == target['q'] and issuing_fleet.r == target['r']):
		return true
	return false
