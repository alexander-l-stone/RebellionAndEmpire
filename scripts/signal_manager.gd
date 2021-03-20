extends Node


signal clear_coordinates
signal hover_hex(q, r)
signal lclick_hex(q, r, sectortype)
signal rclick_hex(q, r)
signal doublelclick_hex(r, q)
signal new_fleet_creation(r, q, i)
signal select_ship_stack(ship_stack)
signal redraw_planet_details_fleet()
signal new_fleet(fleet)
signal new_event_log()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
