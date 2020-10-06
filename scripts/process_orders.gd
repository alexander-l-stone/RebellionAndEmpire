extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_order(order):
	DataStore.order_queue.enqueue(order)

func remove_orders_for_target(target):
	for order in DataStore.order_queue:
		if order.target == target:
			DataStore.order_queue.clear_order(target)

func process_turn():
	var new_queue = DataStore.OrderQueue.new()
	var current_order = DataStore.order_queue.dequeue()
	var move_order_resource = load("res://scenes/move_order/move_order.tscn")
	while (current_order != null):
		#TODO: handle all kinds of orders
		if (current_order is MoveOrder):
			var order_completed = current_order.process_order()
			if(not order_completed):
				var move_path = Constants.a_star(current_order.issuing_fleet.get_location(), current_order.target)
				var move_order = move_order_resource.instance()
				move_order.target = current_order.target
				move_order.issuing_fleet = current_order.issuing_fleet
				var i = 0
				for point in move_path:
					if (i >= current_order.issuing_fleet.fleet_speed):
						break
					move_order.travel_path.append(Constants.convert_string_to_coordinates(point))
					i += 1
				new_queue.enqueue(move_order)
				move_order.issuing_fleet.add_child(move_order)
				move_order.reposition()
			current_order.delete_self()
		current_order = DataStore.order_queue.dequeue()
	DataStore.order_queue = new_queue
		
	#TODO: Handle combat?
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
