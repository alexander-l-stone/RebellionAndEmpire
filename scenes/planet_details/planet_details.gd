extends TabContainer

var planet = null
var fleets = null

var fleet_details_scene = load("res://scenes/planet_details/scenes/fleet_details.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_planet_tab()
	draw_fleets_tab()
	draw_buildings_tab()

func draw_planet_tab():
	if planet != null:
		$Planet/Planet_Sprite.texture = load("res://resources/" + planet.planet_type + ".png")
		$Planet/Planet_Label.text = planet.planet_name

func draw_fleets_tab():
	if (fleets != null) and fleets.size() > 0:
		for fleet in fleets:
			var fleet_scene = fleet_details_scene.instance()
			fleet_scene.fleet = fleet
			$Fleets/FleetScreen_ScrollContainer/Fleets_HBoxContainer.add_child(fleet_scene)

func draw_buildings_tab():
	pass

func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var local_event = make_input_local(event)
		if !Rect2(Vector2(0,0),rect_size).has_point(local_event.position):
			self.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
