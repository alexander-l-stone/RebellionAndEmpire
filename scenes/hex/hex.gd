extends Node

# Use values from 0 to 1
export var red = 0.0
export var green = 0.0
export var blue = 0.0
var alpha = 1.0

export var q = 0
export var r = 0

var focus = false

var sector_type = 'Null'

var inputcount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite_Hex.modulate = Color(red, green, blue)
	SignalManager.connect("lclick_hex", self, "handle_lclick")
	SignalManager.connect("rclick_hex", self, "handle_rclick")

func handle_lclick(q, r, _sector_type):
	if q == self.q and r == self.r:
		self.gain_focus()
	else:
		self.lose_focus()

func handle_rclick(q, r):
	if(DataStore.focused_fleet == null):
		self.lose_focus()
	else:
		if(q == self.q and r == self.r):
			self.move_focused_fleet()

func lose_focus():
	if(focus):
		self.red = self.red * 2
		self.green = self.green * 2
		self.blue = self.blue * 2
		$Sprite_Hex.modulate = Color(self.red, self.green, self.blue, self.alpha)
		focus = false
		for fleet in DataStore.fleets:
			if(fleet.q == q and fleet.r == r):
				fleet.remove_focus()
				break
	else:
		return

func get_self_pos():
	return {'q':q, 'r':r}

func gain_focus():
	if (focus):
		return
	self.red = self.red * 0.5
	self.green = self.green * 0.5
	self.blue = self.blue * 0.5
	$Sprite_Hex.modulate = Color(self.red, self.green, self.blue, self.alpha)
	focus = true
	for fleet in DataStore.fleets:
		if(fleet.q == q and fleet.r == r):
			fleet.toggle_focus()
			break

func move_focused_fleet():
	var move_order_resource = load("res://scenes/move_order/move_order.tscn")
	var move_path = Constants.a_star(DataStore.focused_fleet.get_location(), {'q': self.q, 'r': self.r})
	var move_order = move_order_resource.instance()
	var i = 0
	for point in move_path:
		if (i >= DataStore.focused_fleet.fleet_speed):
			break
		move_order.target = get_self_pos()
		move_order.issuing_fleet = DataStore.focused_fleet
		move_order.travel_path.append(Constants.convert_string_to_coordinates(point))
		i += 1
	DataStore.order_queue.clear_order(DataStore.focused_fleet)
	DataStore.order_queue.enqueue(move_order)
	DataStore.focused_fleet.add_child(move_order)
	move_order.reposition()
	DataStore.focused_fleet.debug_move()

func _on_Hex_mouse_entered():
	self.alpha = 0.50
	$Sprite_Hex.modulate = Color(self.red, self.green, self.blue, self.alpha)
	SignalManager.emit_signal('hover_hex', q, r)


func _on_Hex_mouse_exited():
	self.alpha = 1
	$Sprite_Hex.modulate = Color(self.red, self.green, self.blue, self.alpha)
	SignalManager.emit_signal('clear_coordinates')

func _on_Hex_input_event(_viewport, event, _shape_idx):
	if event.get_class() == "InputEventMouseButton" and event.pressed == false:
		if event.button_index == 1:
			SignalManager.emit_signal('lclick_hex', q, r, sector_type)
		elif event.button_index == 2:
			SignalManager.emit_signal('rclick_hex', q, r)
