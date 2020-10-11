extends Camera2D


export var speed = 12.5
export var height_scroll_margin = 125
export var width_scroll_margin = 125


# Called when the node enters the scene tree for the first time.
func _ready():
	self.make_current()

func move_screen(x,y):
	position.x += x * speed
	position.y += y * speed

func _process(delta):
	var mousePosition = get_viewport().get_mouse_position()
	var visibleRect = get_viewport().get_visible_rect()
	var x = 0
	var y = 0
	if(abs(visibleRect.position.x - mousePosition.x) <= width_scroll_margin):
		x = -1 + abs(visibleRect.position.x - mousePosition.x)/width_scroll_margin
	if(abs(visibleRect.end.x - mousePosition.x) <= width_scroll_margin):
		x = 1 - abs(visibleRect.end.x - mousePosition.x)/width_scroll_margin
	if(abs(visibleRect.position.y - mousePosition.y) <= height_scroll_margin):
		y = -1 + abs(visibleRect.position.y - mousePosition.y)/height_scroll_margin
	#TODO: Find a way to dynamically alter the 256(2x panel height) to be the ui panel
	if(abs(visibleRect.end.y - mousePosition.y - 220) <= height_scroll_margin):
		y = abs(visibleRect.end.y - mousePosition.y - 220)/height_scroll_margin
	if(Input.is_action_pressed("ui_up")):
		y += -1
	if(Input.is_action_pressed("ui_down")):
		y += 1
	if(Input.is_action_pressed("ui_left")):
		x += -1
	if(Input.is_action_pressed("ui_right")):
		x += 1
	move_screen(x, y)
