extends Node


# Declare member variables here. Examples:
# var b = "text"
var rng = RandomNumberGenerator.new()
var sector_centers = [{'q': 0, 'r': 0}, {'q': 2, 'r': 3}, {'q': -3, 'r': 5}, {'q': -5, 'r': 2}, {'q': -2, 'r': -3}, {'q': 3, 'r': -5}, {'q': 5, 'r': -2}]
var galaxy_type = 'normal_galaxy_generation'

const Faction = preload("res://scenes/faction/faction.gd")
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_sectors()
	SignalManager.connect("new_fleet", self, "add_fleet")

func generate_sectors():
	var sector_scene = load("res://scenes/sector/sector.tscn")
	var galaxy_generator = load("res://data/core/galaxy_generation/" + self.galaxy_type + ".tres")
	for faction in galaxy_generator.factions:
		var faction_resource = load("res://data/core/factions/" + faction + ".tres")
		var new_faction = Faction.new()
		new_faction.faction_color = faction_resource.faction_color
		new_faction.faction_name = faction_resource.faction_name
		new_faction.faction_flag_path = faction_resource.faction_flag_path
		#TODO: figure out how player control is determined
		DataStore.factions[new_faction.faction_name] = new_faction
	for coordinate_pair in galaxy_generator.core_sector_coordinate_centers:
		rng.set_seed(coordinate_pair.q + coordinate_pair.r)
		var random_index = rng.randi_range(0, galaxy_generator.core_sectors.size()-1)
		var sector_resource = DataLoader.load_resource('res://data/core/sectors/' + galaxy_generator.core_sectors[random_index] + '.tres')
		var sector = sector_scene.instance()
		sector.q = coordinate_pair.q
		sector.r = coordinate_pair.r
		sector.red = 1
		sector.sector_type = sector_resource.sector_type
		sector.name = String(sector.sector_type) + String(sector.q) + String(sector.r)
		sector.generate_hexes()
		sector.generate_sector(sector_resource)
		add_child(sector)
	for coordinate_pair in galaxy_generator.rim_sector_coordinate_centers:
		rng.set_seed(coordinate_pair.q + coordinate_pair.r)
		var random_index = rng.randi_range(0, galaxy_generator.rim_sectors.size()-1)
		var sector_resource = DataLoader.load_resource('res://data/core/sectors/' + galaxy_generator.rim_sectors[random_index] + '.tres')
		var sector = sector_scene.instance()
		sector.q = coordinate_pair.q
		sector.r = coordinate_pair.r
		var green = rng.randf_range(0,1)
		var blue = rng.randf_range(0,1)
		var red = rng.randf_range(0,1)
		sector.red = red
		sector.blue = blue
		sector.green = green
		sector.name = String(sector.sector_type) + String(sector.q) + String(sector.r)
		sector.sector_type = sector_resource.sector_type
		sector.generate_hexes()
		sector.generate_sector(sector_resource)
		add_child(sector)
	self.test_fleets()

func add_fleet(fleet):
	self.add_child(fleet)
	fleet.reposition()

func test_fleets():
	var fleet_resource = load("res://scenes/fleet/fleet.tscn")
	var fleet1 = fleet_resource.instance()
	var fleet2 = fleet_resource.instance()
	var test_faction = null
	fleet1.q = 1
	fleet1.r = 1
	fleet2.q = 1
	fleet2.r = 1
	fleet2.fleet_speed = 2
	fleet2.combat_strength = 5
	fleet2.fleet_type = "Fast"
	DataStore.fleets.append(fleet1)
	self.add_child(fleet1)
	DataStore.fleets.append(fleet2)
	self.add_child(fleet2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
