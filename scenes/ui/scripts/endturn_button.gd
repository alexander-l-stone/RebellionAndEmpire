extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_click():
	#TODO: Confirmation for end turn
	ProcessOrders.process_turn()
	SignalManager.emit_signal("lclick_hex", 100, 100, '')
	for fleet in DataStore.fleets:
		fleet.remove_focus()
		print(str(fleet))
		print('Q: ' + str(fleet.q) + ', R: ' + str(fleet.r))
		print('X: ' + str(fleet.position.x) + ', Y: ' + str(fleet.position.y))
