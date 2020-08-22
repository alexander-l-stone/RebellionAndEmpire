extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func clear():
	self.text = "X: , Y: "
	print('Recieved clear_coordinates')

func display(q, r):
	self.text = "X: " + String(r) + ", Y: " + String(-q)
	print('Recieved hover_coordinates')
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
