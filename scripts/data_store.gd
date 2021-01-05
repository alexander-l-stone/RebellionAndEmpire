extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sector_types = {}
var planet_types = {
	"asteroid_field": {
		"name": "Asteroid Field",
		"orbital_building_slots": 1,
		"planetary_building_slots": 0,
		"special": {
			"cloaked_all": true,
		},
		"sprite_name": "asteroid_field",
	},
	"barren_planet":
		{
			"name": "Barren Planet",
			"orbital_building_slots": 4,
			"planetary_building_slots": 2,
			"special": {},
			"sprite_name": "habitable_planet",
		},
	"habitable_planet": 
		{
			"name": "Habitable Planet",
			"orbital_building_slots": 4,
			"planetary_building_slots": 4,
			"special": {},
			"sprite_name": "habitable_planet",
		},
}

var building_types = {}

var ship_types = {}

var planets = {}
var fleets = []
var focused_fleet = null
var order_queue = []
var coordinates = {}

var selected_ship_stack = null

func cleanEmptyFleets():
	for fleet in fleets:
		if fleet.contents.size() == 0:
			fleets.erase(fleet)
			fleet.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	var sectors_json = DataLoader.load_data("/core/sectors.json")
	self.sector_types = sectors_json.result
	order_queue = OrderQueue.new()

class OrderQueue:
	var queue = []
	
	func enqueue(order):
		self.queue.append(order)
	
	func dequeue():
		return queue.pop_front()
	
	func clear_order(target):
		var index = self.queue.find(target)
		while index > -1:
			var order = self.queue[index]
			self.queue.remove(index)
			order.delete_self()
			index = self.queue.find(target)
	#TODO: Clear up order removal
	func clear_orders_for_fleet(fleet):
		for order in self.queue:
			if order.issuing_fleet == fleet:
				self.clear_order(order)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
