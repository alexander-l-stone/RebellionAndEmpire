extends Node


signal clear_coordinates
signal hover_hex(q, r)
signal lclick_hex(q, r, sectortype)
signal rclick_hex(q, r)
signal doublelclick_hex(r, q)
signal new_fleet(r, q, i)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
