extends Node

const hex_width = 64
const hex_height = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_coordinates(q, r, node):
	node.set_global_position(Vector2(Constants.hex_height*r*sin(deg2rad(60)),Constants.hex_width*q+cos(deg2rad(60))*r*Constants.hex_height))

func get_adjacent_coordinates(q, r):
	var coord_array = []
	for qloc in range(-1+q, 2+q):
		for rloc in range(-1+r, 2+r):
			if (q != 0) and (r != 0):
				if DataStore.coordinates.has(str(qloc)+str(rloc)):
					coord_array.append({'q': qloc, 'r': rloc})
	return coord_array

func convert_coordinates_to_string(q, r):
	return str(q)+str(r)

#Note the largest coordinate that should be see in a 7
func convert_string_to_coordinates(string):
	var return_dict = {}
	if(string.length == 2):
		return_dict['q'] = int(string.substr(0,1))
		return_dict['r'] = int(string.substr(1,1))
	elif(string.length == 3):
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

func heuristic(coord1, coord2):
	#TODO: Make this better
	return (abs(coord1['q']-coord2['q'])+abs(coord1['r']-coord2['r']))

func a_star(start, target):
	var frontier = PriorityQueue.new(target)
	frontier.enqueue(start)
	var came_from = {}
	var cost_so_far = {}
	came_from[start] = null
	cost_so_far[start] = 0
	while not frontier.empty():
		var current = frontier.dequeue()
	
		if current.data == target:
			break
		
		for next in get_adjacent_coordinates(current.data['q'], current.data['r']):
			#TODO: Calculate actual cost later
			var new_cost = cost_so_far[current.data] + 1
			print('Current:')
			print(current.data)
			print('Next:')
			print(next)
			print('New Cost: ' + str(new_cost))
			if(!cost_so_far.has(next)):
				print('New hex')
			elif(new_cost < cost_so_far[next]):
				print('Cheaper Path Found Than: ' + str(cost_so_far[next]))
			print(came_from)
			print(cost_so_far)
			if (!cost_so_far.has(next)) or (new_cost < cost_so_far[next]):
				cost_so_far[next] = new_cost
				frontier.enqueue(next)
				came_from[next] = current.data
	return came_from
	
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
	
	
