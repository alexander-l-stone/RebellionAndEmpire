extends Node2D

class_name MoveOrder

#target are dicts of the form {'q': int, 'r': int}
var target
var issuing_fleet
var travel_path = []


# Called when the node enters the scene tree for the first time.
func _ready():
	reposition()
	self.visible = false

func reposition():
	for node in travel_path:
		print('Travel Node: ')
		print(node)
		var sprite = Sprite.new()
		sprite.texture = load("res://resources/ship_highlight.png")
		Constants.set_coordinates(node.q, node.r, sprite)
		print(sprite.get_global_position())
		self.add_child(sprite)

func delete_self():
	for child in self.get_children():
		if child is Sprite:
			child.visible = false
		self.remove_child(child)
	self.queue_free()

func process_order():
	#if next_order != null do the todo below
	for node in travel_path:
		issuing_fleet.q = node['q']
		issuing_fleet.r = node['r']
		issuing_fleet.reposition()
		#TODO: Break if there is an enemy here
	self.delete_self()
	if(issuing_fleet.q == target['q'] and issuing_fleet.r == target['r']):
		return true
	return false
