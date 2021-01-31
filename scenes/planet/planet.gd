extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#TODO: Add sprite path
var q = 0
var r = 0

var planet_type = ""
var planet_name = ""

var sprite_path = ""

var planetary_buildings = []
var orbital_buildings = []
var garrison = {}
var special_units = {}
var planetary_building_slots = 0
var orbital_building_slots = 1
var special = {}
var loyalty_level = 'none'
const loyalty_sprite_path = "res://resources/core/images/loyalty/"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.reposition()
	if (self.planet_type == 'habitable_planet' && self.loyalty_level != 'none'):
		self.set_loyalty_sprite()
		self.loyalty_visibility_toggle(true)

func reposition():
	Constants.set_coordinates(q, r, self)

func loyalty_visibility_toggle(visible = true):
	$Loyalty_Sprite.visible = visible

func set_loyalty_sprite():
	$Loyalty_Sprite.texture = load(self.loyalty_sprite_path + "" + self.loyalty_level + ".png")

func add_building(building, building_slot_type):
	if building_slot_type == 'planetary':
		if self.planetary_buildings.size() == self.planetary_building_slots:
			return false
		else:
			self.planetary_buildings.append(building)
			return true
	if building_slot_type == 'orbital':
		if self.orbital_buildings.size() == self.orbital_building_slots:
			return false
		else:
			self.orbital_buildings.append(building)
			return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
