extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sprite_path = "res://resources/heavy_industry.png"

var building_type = "industry"

var cost = 10

var building_effect = "produce-1:I"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = load(sprite_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
