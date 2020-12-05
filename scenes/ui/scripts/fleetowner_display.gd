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
	for fleet in DataStore.fleets:
		if fleet.q == q and fleet.r == r:
			self.text = fleet.faction
			return
	self.clear(q,r)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
