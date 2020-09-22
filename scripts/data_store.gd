extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sector_types = {}
var planet_types = {
	"asteroid_field": {
		"name": "Asteroid Field",
		"sprite_name": "asteroid_field",
		"building_slots": 1,
		"special": {
			"cloaked_all": true,
		},
	},
	"barren_planet":
		{
			"name": "Barren Planet",
			"sprite_name": "habitable_planet",
			"building_slots": 2,
			"special": {},
		},
	"habitable_planet": 
		{
			"name": "Habitable Planet",
			"sprite_name": "habitable_planet",
			"building_slots": 4,
			"special": {},
		},
}

var planets = {}
var fleets = {}
var focused_fleet = null
var order_queue = OrderQueue.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	var sectors_json = DataLoader.load_data("/core/sectors.json")
	self.sector_types = sectors_json.result

class OrderQueue:
	var queue = []
	
	func enqueue(order):
		self.queue.append(order)
	
	func dequeue():
		return queue.pop_front()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
