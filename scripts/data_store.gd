extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sector_types = {}
var planets = {}
var fleets = []
var focused_fleet = null
var order_queue = []
var coordinates = {}
var factions = {}

var selected_ship_stack = null

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
