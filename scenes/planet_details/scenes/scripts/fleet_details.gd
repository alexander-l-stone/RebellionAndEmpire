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
	for child in $FleetDetails_VContainer.get_children():
		child.queue_free()
	var name_str = fleet.fleet_name
	var combat_str = "Combat Strength: " + str(fleet.combat_strength)
	var name_label = Label.new()
	name_label.text = name_str
	var combat_label = Label.new()
	combat_label.text = combat_str
	$FleetDetails_VContainer.add_child(name_label)
	$FleetDetails_VContainer.add_child(combat_label)

func _input(event):
	if(mouse_inside):
		if (event is InputEventMouseButton) and event.pressed:
			DataStore.focused_fleet = self.fleet
			SignalManager.emit_signal("redraw_planet_details_fleet")

func _on_FleetDetails_mouse_entered():
	self.mouse_inside = true


func _on_FleetDetails_mouse_exited():
	self.mouse_inside = false
