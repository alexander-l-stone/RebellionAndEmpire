extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect('lclick_hex', self, 'display')
	SignalManager.connect('rclick_hex', self, 'clear')

func clear(_q, _r):
	self.text = ""
	
func display(q, r, sectortype):
	if(DataStore.planets.has(str(q) + str(r))):
		self.text = DataStore.planets[str(q) + str(r)].planet_name
	else:
		self.text = ""



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
