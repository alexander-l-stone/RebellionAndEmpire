extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func process_turn():
	var new_queue = DataStore.OrderQueue.new()
	var current_order = DataStore.order_queue.dequeue()
	var move_order_resource = load("res://move_order/move_order.tscn")
	while (current_order != null):
		#TODO: handle all kinds of orders
		if (current_order.get_class() == "MoveOrder"):
			var order_result = current_order.process_order()
			if(order_result.get_class() == "MoveOrder"):
				DataStore.order_queue.enqueue(order_result)
			elif(order_result.get_class() == "Dictionary"):
				var new_move_order = move_order_resource.instance()
				new_move_order.target = order_result
				new_move_order.issuing_fleet = current_order.issuing_fleet
				#TODO: Pathfind the next orders
	#TODO: Handle combat?
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
