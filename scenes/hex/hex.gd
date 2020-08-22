extends Node

# Use values from 0 to 1
export var red = 0.0
export var green = 0.0
export var blue = 0.0
var alpha = 1.0

export var q = 0
export var r = 0

var sector_type = 'Null'

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite_Hex.modulate = Color(red, green, blue)
	SignalManager.connect("lclick_hex", self, "handle_lclick")
	SignalManager.connect("rclick_hex", self, "handle_rclick")

func handle_lclick(q, r, _sector_type):
	if q == self.q and r == self.r:
		print('Incoming q: ' + String(q))
		print('My q: ' + String(self.q))
		print('Incoming r: ' + String(r))
		print('My r: ' + String(self.r))
		self.alpha = 0.40
		$Sprite_Hex.modulate = Color(red, green, blue, alpha)
	else:
		self.alpha = 1
		$Sprite_Hex.modulate = Color(red, green, blue, alpha)

func handle_rclick(_q, _r):
	self.alpha = 1
	$Sprite_Hex.modulate = Color(red, green, blue, alpha)

func _on_Hex_mouse_entered():
	$Sprite_Hex.modulate = Color(max(0, red-0.25), max(0, green-0.25), max(0, blue-0.25), alpha)
	SignalManager.emit_signal('hover_hex', q, r)
	print('Emitting Signal hover_coordinates')

func _on_Hex_mouse_exited():
	$Sprite_Hex.modulate = Color(red, green, blue, alpha)
	SignalManager.emit_signal('clear_coordinates')
	print('Emitting Signal clear_coordinates')


func _on_Hex_input_event(_viewport, event, _shape_idx):
	if event.get_class() == "InputEventMouseButton" and event.pressed == true:
		if event.button_index == 1:
			SignalManager.emit_signal('lclick_hex', q, r, sector_type)
			print('Emitting Signal lclick_hex')
		elif event.button_index == 2:
			SignalManager.emit_signal('rclick_hex', q, r)
			print('Emitting Signal rclick_hex')
