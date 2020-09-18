extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var q = 0
var r = 0

var type = "barren_planet"

var buildings = []
var garrison = {}
var special_units = {}
var building_slots = 2
var special = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	reposition()

func reposition():
	self.set_global_position(Vector2(Constants.hex_height*self.r*sin(deg2rad(60)),Constants.hex_width*self.q+cos(deg2rad(60))*self.r*Constants.hex_height))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
