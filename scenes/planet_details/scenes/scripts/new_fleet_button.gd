extends Button

var r
var q
var index


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_NewFleetButton_button_down():
	SignalManager.emit_signal("new_fleet", r, q, index)
