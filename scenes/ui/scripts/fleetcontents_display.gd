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
			var display_string = str(entry[entry.keys()[0]]) + "x " + entry.keys()[0].capitalize()
			var new_listing = Label.new()
			new_listing.text = display_string
			$UI_FleetContent_VerticalScroll.add_child(new_listing)
	

func count_contents(fleet):
	var return_array = []
	for ship_type in fleet.contents.keys():
		var array_entry = {ship_type : fleet.contents[ship_type].size()}
		return_array.append(array_entry)
	return return_array
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
