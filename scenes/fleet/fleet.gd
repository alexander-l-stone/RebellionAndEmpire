extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var q = 0
var r = 0

var fleet_speed = 1
var faction = "rebellion"
var focused = false
var fleet_name = "Fleet"

var fleet_type = "Normal"
var combat_strength = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	reposition()
	set_fleet_name(self.faction)
	set_fleet_color(self.faction)

func set_fleet_name(faction):
	if (faction in DataStore.factions):
		self.fleet_name = DataStore.factions[faction].faction_name.capitalize() + " Fleet"

func set_fleet_color(faction):
	if(faction in DataStore.factions):
		$Sprite_Fleet.modulate = DataStore.factions[faction].faction_color

func reposition():
	Constants.set_coordinates(q, r, self)

func get_location():
	return {'q': self.q, 'r': self.r}

func toggle_focus():
	if(focused):
		remove_focus()
	else:
		gain_focus()

func debug_move():
	for node in self.get_children():
		if node is MoveOrder:
			print("Move Order: ")
			print('Node')
			print(node)
			print('Travel path')
			print(node.travel_path)
			print("Visible")
			print(node.visible)

func gain_focus():
	focused = true
	$Sprite_FleetHighlight.visible = true
	DataStore.focused_fleet = self
	for node in self.get_children():
		if node is MoveOrder:
			node.visible = true

func remove_focus():
	focused = false
	$Sprite_FleetHighlight.visible = false
	DataStore.focused_fleet = null
	for node in self.get_children():
		if node is MoveOrder:
			node.visible = false

class ShipTypeSorter:
	static func sort_by_ship_name(a, b):
		if (a.keys()[0] <= b.keys()[0]):
			return true
		return false

#TODO: Add a remove_ship and get_ship function

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
