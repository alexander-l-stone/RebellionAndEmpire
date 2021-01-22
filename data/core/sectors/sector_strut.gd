extends Resource

export var fields = ['type', 'sector_type', 'planets', 'optional_planets', 'optional_min_range', 'optional_max_range']
export var type = 'sector'
export var sector_type = 'core_sector'
export var planet_types = ['asteroid_field', 'barren_planet', 'habitable_planet']
export var planets = {
	'habitable_planet': [
		{
		'orbital_buildings': ['shipyard'],
		'planetary_buildings': ['industry'] 
		}
	],
	'barren_planet': [
		{
		'orbital_buildings': [],
		'planetary_buildings': [] 
		}
	],
	'asteroid_field': [
		{
		'orbital_buildings': [],
		'planetary_buildings': [] 
		}
	]
}
export var optional_planet_types = []
export var optional_planets = {}
export var optional_min_range = 0
export var optional_max_range = 0
