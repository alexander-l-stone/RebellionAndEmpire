extends Node2D


#target are dicts of the form {'q': int, 'r': int}
var target
var issuing_fleet
var next_order

class_name MoveOrder

# Called when the node enters the scene tree for the first time.
func _ready():
	Constants.set_coordinates(target['q'], target['r'], $MoveOrder_Sprite)

func process_order():
	#if next_order != null do the todo below
	#TODO: Check if the next_target has an enemy in it. If so, recalculate
	issuing_fleet.q = target['q']
	issuing_fleet.r = target['r']
	return next_order
