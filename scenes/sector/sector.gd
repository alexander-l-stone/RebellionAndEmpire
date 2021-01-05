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
	#TODO: Remove this if when more sector types are implemented
	if(self.sector_type == "core"):
		generate_planets(coordinate_array)

#coordinate_array is an array of dicts. Those dicts are of form {'q':int, 'r':int}
func generate_planets(coordinate_array):
	var sector_guide = {}
	var rng = RandomNumberGenerator.new()
	var planet_resource = load("res://scenes/planet/planet.tscn")
	if(self.sector_type == "core"):
		sector_guide = DataStore.sector_types.core
	for planet_type in sector_guide.planets:
		#pick random coordiante from array
		var random_coord_index = rng.randf_range(0, coordinate_array.size())
		var planet = planet_resource.instance()
		var planet_data = DataStore.planet_types[planet_type]
		planet.texture = load("res://resources/" + planet_type + ".png")
		planet.q = coordinate_array[random_coord_index]["q"]
		planet.r = coordinate_array[random_coord_index]["r"]
		coordinate_array.remove(random_coord_index)
		planet.planet_type = planet_type
		planet.planet_name = planet_data["name"]
		planet.planetary_building_slots = planet_data["planetary_building_slots"]
		planet.orbital_building_slots = planet_data["orbital_building_slots"]
		#for x in range(0,6):
		#	var orbital_building = self.building_scene.instance()
		#	var planetary_building = self.building_scene.instance()
		#	planet.add_building(orbital_building, 'orbital')
		#	planet.add_building(planetary_building, 'planetary')
		planet.special = planet_data['special']
		DataStore.planets[Constants.convert_coordinates_to_string(planet.q, planet.r)] = planet
		add_child(planet)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
