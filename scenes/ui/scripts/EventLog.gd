extends CheckButton

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("new_event_log", self, 'generate_popup_menu')

func generate_popup_menu():
	for child in $UI_EventLog_Messages.get_children():
		child.queue_free()
	for event in DataStore.event_log:
		var new_label = Label.new()
		new_label.text = event
		$UI_EventLog_Messages.add_child(new_label)

func _on_UI_EventLog_CheckBox_toggled(button_pressed):
	if(button_pressed):
		$UI_EventLog_Messages.visible = true
	else:
		$UI_EventLog_Messages.visible = false
