extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var q = 0
export var r = 0
export var sector_type = 'normal'
export var red = 0.0
export var green = 0.0
export var blue = 0.0

var building_scene = load("res://scenes/building/building.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Make all the hexes
	#TODO: Move this out of _ready to a function that doesn't run when this is loaded from a save
	pass

func generate_sector(sector_resource = null):
	var coordinate_array = self.generate_hexes()
	if(sector_resource != null):
		generate_planets(coordinate_array, sector_resource)

func generate_hexes():
	var coordinate_array = []
	var hex_resource = load("res://scenes/hex/hex.tscn")
	for qloc in range(-2+q, 3+q):
		for rloc in range(-2+r, 3+r):
			if ((qloc-q)+(rloc-r) > -3) && ((qloc-q)+(rloc-r) < 3):
				coordinate_array.append({'q': qloc, 'r': rloc})
				DataStore.coordinates[str(qloc)+str(rloc)] = true
				var hex = hex_resource.instance()
				Constants.set_coordinates(qloc, rloc, hex)
				hex.red = red
				hex.green = green
				hex.blue = blue
				hex.r = rloc
				hex.q = qloc
				hex.sector_type = self.sector_type
				add_child(hex)
	return coordinate_array
	#TODO: Remove this if when more sector types are implemented
	if(self.sector_type == "core"):
		generate_planets(coordinate_array)

#coordinate_array is an array of dicts. Those dicts are of form {'q':int, 'r':int}
#TODO: remove sector_resource = null when all sectors are implemented
func generate_planets(coordinate_array, sector_resource = null):
	if sector_resource == null:
		return false
	var planet_scene = load("res://scenes/planet/planet.tscn")
	var building_scene = load("res://scenes/building/building.tscn")
	var rng = RandomNumberGenerator.new()
	for planet_type in sector_resource.planet_types:
		var planet_resource = DataLoader.load_resource("res://data/core/planets/" + planet_type + '.tres')
		for planet in sector_resource.planets[planet_type]:
			var random_coord_index = rng.randf_range(0, coordinate_array.size())
			var new_planet = planet_scene.instance()
			new_planet.texture = load("res://resources/" + planet_resource["sprite_path"])
			new_planet.sprite_path = planet_resource["sprite_path"]
			new_planet.r = coordinate_array[random_coord_index]["r"]
			new_planet.q = coordinate_array[random_coord_index]["q"]
			coordinate_array.remove(random_coord_index)
			new_planet.planet_type = planet_type
			new_planet.planet_name = planet_resource["planet_type"] + ': ' + str(new_planet.r) + ', ' + str(new_planet.q)
			new_planet.planetary_building_slots = planet_resource["planetary_building_slots"]
			new_planet.orbital_building_slots = planet_resource["orbital_building_slots"]
			new_planet.special = planet_resource["special"]
			for planetary_building in planet.planetary_buildings:
				var building_resource = DataLoader.load_resource("res://data/core/buildings/" + planetary_building + '.tres')
				var new_building = building_scene.instance()
				new_building.texture = load("res://resources/" + building_resource.sprite_path)
				new_building.sprite_path = building_resource.sprite_path
				new_building.building_type = building_resource.building_type
				new_building.cost = building_resource.cost
				new_building.building_effect = building_resource.building_effect
				new_planet.add_building(new_building, 'planetary')
			for orbital_building in planet.orbital_buildings:
				var building_resource = DataLoader.load_resource("res://data/core/buildings/" + orbital_building + '.tres')
				var new_building = building_scene.instance()
				new_building.texture = load("res://resources/" + building_resource.sprite_path)
				new_building.sprite_path = building_resource.sprite_path
				new_building.building_type = building_resource.building_type
				new_building.cost = building_resource.cost
				new_building.building_effect = building_resource.building_effect
				new_planet.add_building(new_building, 'orbital')
			DataStore.planets[Constants.convert_coordinates_to_string(new_planet.q, new_planet.r)] = new_planet
			self.add_child(new_planet)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
