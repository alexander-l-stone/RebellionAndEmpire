extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_building(building, slot_type='orbital'):
	self.add_child(building)
	building.position.x = self.rect_min_size.x/2
	building.position.y = self.rect_min_size.y/2
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
