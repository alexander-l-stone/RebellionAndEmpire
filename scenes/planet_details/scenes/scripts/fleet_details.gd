extends PanelContainer


var fleet = null

var ship_stack_scene = load("res://scenes/planet_details/scenes/ship_stack.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if fleet != null:
		reset_display()
		set_display(fleet.count_contents())

func reset_display():
	for child in $FleetDetails_GridContainer.get_children():
		child.queue_free()

func set_display(ships):
	for key in ships.keys():
		var ship_type = key
		var num_ship_type = ships[key]
		var ship_stack = ship_stack_scene.instance()
		ship_stack.ship_type = ship_type
		ship_stack.ship_number = num_ship_type
		ship_stack.fleet = fleet
		$FleetDetails_GridContainer.add_child(ship_stack)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
