extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect('hover_hex', self, 'display')
	SignalManager.connect('clear_coordinates', self, 'clear')

func clear():
	self.text = ""

func display(q, r):
	self.text = "X: " + String(r) + ", Y: " + String(-q)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
