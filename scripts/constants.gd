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
		{'r': r-1, 'q': q+1},
		{'r': r, 'q': q-1},
		{'r': r, 'q': q+1},
		{'r': r-1, 'q': q},
		{'r': r+1, 'q': q},
		{'r': r+1, 'q': q-1},
	]
	return coord_array
#TODO: Swap q, r to r, q
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
			if (not cost_so_far.has(convert_coordinates_to_string(next.q, next.r))) or (new_cost < cost_so_far[convert_coordinates_to_string(next.q, next.r)]):
				cost_so_far[convert_coordinates_to_string(next.q, next.r)] = new_cost
				came_from[convert_coordinates_to_string(next.q, next.r)] = convert_coordinates_to_string(current.data.q, current.data.r)
				frontier.enqueue(next)
	var path_array = [convert_coordinates_to_string(target.q, target.r)]
	var start_coord = convert_coordinates_to_string(start.q, start.r)

	while (path_array[0] != start_coord):
		path_array.push_front(came_from[path_array[0]])
	for entry in path_array:
		entry = convert_string_to_coordinates(entry)
	return path_array.slice(1, path_array.size() - 1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# data is of form {'q':int, 'r':int}
class PQNode:
		var data: Dictionary
		var priority: int
		
		func _init(data, target):
			self.data = data
			self.priority = Constants.heuristic(self.data, target)

class PriorityQueue:
	var heap = []
	var target: Dictionary
	var distance: int
	
	func _init(target):
		self.target = target
		
	func empty():
		return (self.heap.size() == 0)
	
	func left_pos(i):
		return 2*i
	
	func right_pos(i):
		return 2*i+1
	
	func parent_pos(i):
		return int(i/2)
	
	func is_leaf(i): 
		if i >= (int(self.heap.size()/2)) and i <= self.heap.size(): 
			return true
		return false
	
	func swap_pos(fpos, spos):
		var temp = self.heap[spos]
		self.heap[spos] = self.heap[fpos]
		self.heap[fpos] = temp
	
	func minify_heap(i):
		if not self.is_leaf(i):
			if(self.heap[i].priority) > self.heap[self.left_pos(i)].priority:
				self.swap_pos(i, self.left_pos(i))
				self.minify_heap(self.left_pos(i))
			elif(self.heap[i].priority) > self.heap[self.right_pos(i)].priority:
				self.swap_pos(i, self.right_pos(i))
				self.minify_heap(self.right_pos(i))
	
	func enqueue(data):
		var new_node = PQNode.new(data, self.target)
		self.heap.append(new_node)
		var current = self.heap.size() - 1
		while (self.heap[current].priority < self.heap[self.parent_pos(current)].priority):
			self.swap_pos(current, self.parent_pos(current))
			current = self.parent_pos(current)
	
	func dequeue():
		var front_element = self.heap[0]
		self.heap[0] = self.heap[self.heap.size() - 1]
		self.heap.pop_back()
		self.minify_heap(0)
		return front_element
	
	
