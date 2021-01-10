extends Node


# Declare member variables here. Examples:
# var b = "text"
var rng = RandomNumberGenerator.new()
var sector_centers = [{'q': 0, 'r': 0}, {'q': 2, 'r': 3}, {'q': -3, 'r': 5}, {'q': -5, 'r': 2}, {'q': -2, 'r': -3}, {'q': 3, 'r': -5}, {'q': 5, 'r': -2}]
signal generate
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_sectors()
	SignalManager.connect("new_fleet", self, "add_fleet")

func generate_sectors():
	var sector_scene = load("res://scenes/sector/sector.tscn")
	for sector_point in sector_centers:
		var sector_resource = DataLoader.load_resource('res://data/core/sectors/core_sector.tres')
		var sector = sector_scene.instance()
		sector.q = sector_point.q
		sector.r = sector_point.r
		if(sector_point.q == 0 && sector_point.r == 0):
			sector.sector_type = 'core'
			sector.red = 1
		else:
			rng.randomize()
			var green = rng.randf_range(0,1)
			var blue = rng.randf_range(0,1)
			var red = rng.randf_range(0,1)
			sector.red = red
			sector.blue = blue
			sector.green = green
		sector.name = String(sector.sector_type) + String(sector.q) + String(sector.r)
		if(sector.sector_type == 'core'):
			sector.generate_sector(sector_resource)
		sector.generate_hexes()
		add_child(sector)

func add_fleet(fleet):
	self.add_child(fleet)
	fleet.reposition()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
