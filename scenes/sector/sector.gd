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
				var hex = hex_resource.instance()
				hex.set_global_position(Vector2(Constants.hex_height*rloc*sin(deg2rad(60)),Constants.hex_width*qloc+cos(deg2rad(60))*rloc*Constants.hex_height))
				hex.red = red
				hex.green = green
				hex.blue = blue
				hex.r = rloc
				hex.q = qloc
				hex.sector_type = self.sector_type
				add_child(hex)
				#TODO: Remove this if when more sector types are implemented
	if(self.sector_type == "core"):
		generate_planets()

func generate_planets():
	if(self.sector_type == "core"):
		var sector_guide = DataStore.sector_types.core
		print(sector_guide)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
