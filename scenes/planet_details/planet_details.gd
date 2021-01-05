extends TabContainer

var planet = null
var fleets = null

var fleet_scene = load("res://scenes/fleet/fleet.tscn")
var fleet_details_scene = load("res://scenes/planet_details/scenes/fleet_details.tscn")
var planetary_building_details_scene = load("res://scenes/planet_details/scenes/planetary_building_details.tscn")
var orbital_building_details_scene = load("res://scenes/planet_details/scenes/orbital_building_details.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_planet_tab()
	draw_fleets_tab()
	SignalManager.connect("new_fleet_creation", self, "new_fleet")
	SignalManager.connect("select_ship_stack", self, "on_select_ship_stack")
	SignalManager.connect("redraw_planet_details_fleet", self, "redraw_fleets")

func redraw_fleets():
	self.clear('fleet')
	self.draw_fleets_tab()

func redraw_planet():
	self.clear('planet')
	self.draw_fleets_tab()

func draw_planet_tab():
	if self.planet != null:
		print(self.planet.planet_name)
		$Planet/Planet_Sprite.texture = load("res://resources/" + planet.planet_type + ".png")
		$Planet/Planet_Label.text = planet.planet_name
		for i in range(0, planet.planetary_building_slots):
			var new_building_details = self.planetary_building_details_scene.instance()
			if i < planet.planetary_buildings.size():
				new_building_details.add_building(planet.planetary_buildings[i].duplicate())
			$Planet/Planetary_Buildings_Container.add_child(new_building_details)
		for i in range(0, planet.orbital_building_slots):
			var new_building_details = self.orbital_building_details_scene.instance()
			if i < planet.orbital_buildings.size():
				new_building_details.add_building(planet.orbital_buildings[i].duplicate())
			$Planet/Orbital_Buildings_Container.add_child(new_building_details)

func draw_fleets_tab():
	if (fleets != null) and fleets.size() > 0:
		var i = 0
		for fleet in fleets:
			var fleet_details = self.fleet_details_scene.instance()
			fleet_details.index = i
			fleet_details.fleet = fleet
			$Fleets/FleetScreen_ScrollContainer/Fleets_HBoxContainer.add_child(fleet_details)
			i += 1
	
func on_select_ship_stack(ship_stack):
	if (DataStore.selected_ship_stack != null):
		DataStore.selected_ship_stack.unselect_self()
	DataStore.selected_ship_stack = ship_stack
	
func on_transfer_ship_stack(ship_stack, fleet):
	var found_ship = ship_stack.fleet.remove_ship_of_type(ship_stack.ship_type)
	if(found_ship != null):
		fleet.add_ship(found_ship)
	DataStore.focused_fleet = fleet
	self.redraw_fleets()

func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var local_event = make_input_local(event)
		if !Rect2(Vector2(0,0),rect_size).has_point(local_event.position):
			DataStore.cleanEmptyFleets()
			self.queue_free()

func new_fleet(r, q, index):
	var new_fleet = self.fleet_scene.instance()
	new_fleet.r = r
	new_fleet.q = q
	new_fleet.name = str(index+1)
	fleets.insert(index+1, new_fleet)
	DataStore.fleets.append(new_fleet)
	self.redraw_fleets()
	SignalManager.emit_signal("new_fleet", new_fleet)

func clear(tab = 'all'):
	if (tab == 'all' or tab == 'fleet'):
		for child in $Fleets/FleetScreen_ScrollContainer/Fleets_HBoxContainer.get_children():
			child.queue_free()
	if (tab == 'all' or tab == 'planet'):
		for child in $Planet/Planetary_Buildings_Container:
			child.queue_free()
	if (tab == 'all' or tab == 'planet'):
		for child in $Planet/Orbital_Buildings_Container:
			child.queue_free()
