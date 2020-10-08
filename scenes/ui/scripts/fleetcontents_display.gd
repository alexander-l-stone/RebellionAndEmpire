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
	if(DataStore.fleets.has(str(q) + str(r))):
		var contents = count_contents(DataStore.fleets[str(q) + str(r)])
		var i = 0
		for entry in contents:
			i+=1
			#TODO fix this
			var display_string = str(entry[0]) + "x " + str(entry[1]).capitalize()
			var new_listing = Label.new()
			new_listing.text = display_string
			$UI_FleetContent_VerticalScroll.add_child(new_listing)
	

func count_contents(fleet):
	var return_array = []
	for ship in fleet.contents:
		var ship_index = return_array.find(ship.ship_type)
		if not ship_index == -1:
			return_array[ship_index][ship.ship_type] += 1
		else:
			return_array.append({ship.ship_type: 1})
	return return_array
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
