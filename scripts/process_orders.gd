extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_order(order):
	DataStore.order_queue.enqueue(order)

func process_turn():
	var new_queue = DataStore.OrderQueue.new()
	var current_order = DataStore.order_queue.dequeue()
	var move_order_resource = load("res://move_order/move_order.tscn")
	while (current_order != null):
		#TODO: handle all kinds of orders
		if (current_order is MoveOrder):
			var order_completed = current_order.process_order()
			if(not order_completed):
				#TODO: A* the new path
				pass
	#TODO: Handle combat?
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
