extends PanelContainer


var fleet = null
var index: int = 0

var ship_stack_scene = load("res://scenes/planet_details/scenes/ship_stack.tscn")
var new_fleet_button = load("res://scenes/planet_details/scenes/new_fleet_button.tscn")

var mouse_inside = false

var focused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if fleet != null:
		reset_display()
		set_display(self.fleet.count_contents())
		print(DataStore.focused_fleet)
		print(fleet)
		if (DataStore.focused_fleet == fleet):
			self.modulate = Color(0, 1.0, 0)
			self.focused = true

func reset_display():
	for child in $FleetDetails_GridContainer.get_children():
		child.queue_free()

func set_display(ships):
	var i = 0
	for key in ships.keys():
		var ship_type = key
		var num_ship_type = ships[key]
		var ship_stack = ship_stack_scene.instance()
		ship_stack.ship_type = ship_type
		ship_stack.ship_number = num_ship_type
		ship_stack.fleet = fleet
		ship_stack.index = i
		i += 1
		$FleetDetails_GridContainer.add_child(ship_stack)
	var button = new_fleet_button.instance()
	button.r = fleet.r
	button.q = fleet.q
	button.index = index
	$FleetDetails_GridContainer.add_child(button)

func _input(event):
	if(mouse_inside):
		if (event is InputEventMouseButton) and event.pressed:
			print('Mouse Click: ' + str(self))


func _on_FleetDetails_mouse_entered():
	self.mouse_inside = true


func _on_FleetDetails_mouse_exited():
	self.mouse_inside = false
