extends TabContainer

var planet = null
var fleets = null

var fleet_scene = load("res://scenes/fleet/fleet.tscn")
var fleet_details_scene = load("res://scenes/planet_details/scenes/fleet_details.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_planet_tab()
	draw_fleets_tab()
	draw_buildings_tab()
	SignalManager.connect("new_fleet", self, "new_fleet")
	SignalManager.connect("select_ship_stack", self, "on_select_ship_stack")

func draw_planet_tab():
	if planet != null:
		print(planet.planet_name)
		$Planet/Planet_Sprite.texture = load("res://resources/" + planet.planet_type + ".png")
		$Planet/Planet_Label.text = planet.planet_name

func draw_fleets_tab():
	if (fleets != null) and fleets.size() > 0:
		var i = 0
		for fleet in fleets:
			var fleet_details = fleet_details_scene.instance()
			fleet_details.index = i
			fleet_details.fleet = fleet
			$Fleets/FleetScreen_ScrollContainer/Fleets_HBoxContainer.add_child(fleet_details)
			i += 1

func draw_buildings_tab():
	pass
	
func on_select_ship_stack(ship_stack):
	if (DataStore.selected_ship_stack != null):
		DataStore.selected_ship_stack.unselect_self()
	DataStore.selected_ship_stack = ship_stack
	

func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var local_event = make_input_local(event)
		if !Rect2(Vector2(0,0),rect_size).has_point(local_event.position):
			DataStore.cleanEmptyFleets()
			self.queue_free()

func new_fleet(_r, _q, index):
	fleets.insert(index+1, fleet_scene.instance())
	clear()
	draw_fleets_tab()

func clear():
	for child in $Fleets/FleetScreen_ScrollContainer/Fleets_HBoxContainer.get_children():
		child.queue_free()
