extends ScrollContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect('lclick_hex', self, 'display')
	SignalManager.connect('rclick_hex', self, 'clear')

func clear(_q, _r):
	for n in $UI_FleetContent_VerticalScroll.get_children():
		n.queue_free()
	
func display(q, r, _sectortype):
	clear(q, r)
	for fleet in DataStore.fleets:
		if fleet.q == q and fleet.r == r:
			var contents = fleet.count_contents()
			print(contents)
			for entry in contents:
				var display_string = str(entry.keys()[0]).capitalize() + ' ' + str(entry[entry.keys()[0]])
				var new_listing = Label.new()
				new_listing.text = display_string
				$UI_FleetContent_VerticalScroll.add_child(new_listing)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
