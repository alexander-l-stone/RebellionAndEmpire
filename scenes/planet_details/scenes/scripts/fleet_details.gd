extends PanelContainer


var fleet = null
var index: int = 0

var mouse_inside = false

var focused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if fleet != null:
		reset_display()
		if (DataStore.focused_fleet == fleet):
			self.modulate = Color(0, 1.0, 0)
			self.focused = true

func reset_display():
	for child in $FleetDetails_GridContainer.get_children():
		child.queue_free()

func _input(event):
	if(mouse_inside):
		if (event is InputEventMouseButton) and event.pressed:
			DataStore.focused_fleet = self.fleet
			SignalManager.emit_signal("redraw_planet_details_fleet")

func _on_FleetDetails_mouse_entered():
	self.mouse_inside = true


func _on_FleetDetails_mouse_exited():
	self.mouse_inside = false
