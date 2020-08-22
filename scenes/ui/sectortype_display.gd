extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	SignalManager.connect('lclick_hex', self, 'display')
	SignalManager.connect('rclick_hex', self, 'clear')
	pass

# Called when the node enters the scene tree for the first time.
func clear(_q, _r):
	self.text = ""

func display(_q, _r, sector_type):
	self.text = "Sector Type: " + String(sector_type)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
