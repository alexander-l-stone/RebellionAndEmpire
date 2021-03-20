extends MenuButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("new_event_log", self, 'generate_popup_menu')

func generate_popup_menu():
	for child in $UI_EventLog_PopupMenu.get_children():
		child.queue_free()
	for event in DataStore.event_log:
		$UI_EventLog_PopupMenu.add_item(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
