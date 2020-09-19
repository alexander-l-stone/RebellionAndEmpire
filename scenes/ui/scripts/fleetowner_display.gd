extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect('lclick_hex', self, 'display')
	SignalManager.connect('rclick_hex', self, 'clear')

func clear(q, r):
	self.text = ""
	
func display(q, r, _sectortype):
	if(DataStore.fleets.has(str(q) + str(r))):
		self.text = DataStore.fleets[str(q) + str(r)].controller
	else:
		self.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
