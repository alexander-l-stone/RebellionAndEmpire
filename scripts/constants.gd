extends Node

const hex_width = 64
const hex_height = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_coordinates(q, r, node):
	node.set_global_position(Vector2(Constants.hex_height*r*sin(deg2rad(60)),Constants.hex_width*q+cos(deg2rad(60))*r*Constants.hex_height))

func get_adjacent_coordinates(q, r):
	var coord_array = [
		{'q': q-1,'r': r-1},
		{'q': q-1,'r': r},
		{'q': q+1,'r': r},
		{'q': q,'r': r-1},
		{'q': q,'r': r+1},
		{'q': q+1,'r': r+1},
	]
	return coord_array

func convert_coordinates_to_string(q, r):
	return str(q)+str(r)

#Note the largest coordinate that should be see in a 7
func convert_string_to_coordinates(string):
	var return_dict = {}
	if(string.length() == 2):
		return_dict['q'] = int(string.substr(0,1))
		return_dict['r'] = int(string.substr(1,1))
	elif(string.length() == 3):
		if(string.substr(0,1) == '-'):
			return_dict['q'] = int(string.substr(0,2))
			return_dict['r'] = int(string.substr(2,1))
		else:
			return_dict['q'] = int(string.substr(0,1))
			return_dict['r'] = int(string.substr(1,2))
	else:
		return_dict['q'] = int(string.substr(0,2))
		return_dict['r'] = int(string.substr(2,2))
	return return_dict

func distance_between_points(a, b):
	return (abs(a.q - b.q) + abs(a.q + a.r - b.q - b.r) + abs(a.r - b.r)) / 2

func heuristic(coord1, coord2):
	#TODO: Make this better
	return (distance_between_points(coord1, coord2))

func a_star(start, target):
	var frontier = PriorityQueue.new(target)
	frontier.enqueue(start)
	var came_from = {}
	var cost_so_far = {}
	came_from[convert_coordinates_to_string(start.q, start.r)] = convert_coordinates_to_string(start.q, start.r)
	cost_so_far[convert_coordinates_to_string(start.q, start.r)] = 0
	while not frontier.empty():
		var current = frontier.dequeue()
	
		if (current.data.q == target.q) and (current.data.r == target.r):
			break
		
		for next in get_adjacent_coordinates(current.data['q'], current.data['r']):
			#TODO: Calculate actual cost later
			var new_cost = cost_so_far[convert_coordinates_to_string(current.data.q, current.data.r)] + 1
			if (!cost_so_far.has(next)) or (new_cost < cost_so_far[next]):
				cost_so_far[convert_coordinates_to_string(next.q, next.r)] = new_cost
				frontier.enqueue(next)
				came_from[convert_coordinates_to_string(next.q, next.r)] = convert_coordinates_to_string(current.data.q, current.data.r)
	var path_array = [convert_coordinates_to_string(target.q, target.r)]
	print(convert_coordinates_to_string(start.q, start.r))
	var i := 0
	while (path_array[path_array.size()-1] != convert_coordinates_to_string(start.q, start.r)):
		print(path_array)
		path_array.append(came_from[path_array[path_array.size()-1]])
		i += 1
		if (i == 10):
			break
	for entry in path_array:
		entry = convert_string_to_coordinates(entry)
	return path_array
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# data is of form {'q':int, 'r':int}
class PQNode:
		var data: Dictionary
		var priority: int
		var next
		
		func _init(data, target):
			self.data = data
			self.priority = Constants.heuristic(self.data, target)

class PriorityQueue:
	var head = null
	var target: Dictionary
	var distance: int
	
	func _init(target):
		self.target = target
		
	func empty():
		return (self.head == null)
	
	func enqueue(data):
		var new_node = PQNode.new(data, self.target)
		if(self.head == null or typeof(self.head) == 18):
			self.head = new_node
		else:
			var curr_node = self.head
			while(new_node.priority >= curr_node.priority):
				if(curr_node.next == null):
					curr_node.next = new_node
					return
				else:
					curr_node = curr_node.next
			new_node.next = curr_node.next
			curr_node.next = new_node
	
	func dequeue():
		if(self.head != null):
			var return_node = self.head
			self.head = self.head.next
			return return_node
		else:
			return null
	
	
