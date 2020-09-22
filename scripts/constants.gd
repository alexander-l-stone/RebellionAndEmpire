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

func heuristic(coord1, coord2):
	#TODO: Make this better
	return (abs(coord1['q']-coord2['q'])+abs(coord1['r']-coord2['r']))

func a_star(start, target):
	var frontier = Constants.PriorityQueue(target)
	frontier.enqueue(start)
	var came_from = {}
	var cost_so_far = {}
	came_from[start] = null
	cost_so_far[start] = 0
	
	while not frontier.empty():
		var current = frontier.dequeue()
	
		if current == target:
			break
		
		for next in get_adjacent_coordinates(current['q'], current['r']):
			#TODO: Calculate actual cost later
			var new_cost = cost_so_far[current] + 1
			if (cost_so_far.has(next)) or (new_cost < cost_so_far[next]):
				cost_so_far[next] = new_cost
				frontier.enqueue(next)
				came_from[next] = current
				
	return came_from
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# data is of form {'q':int, 'r':int}
class PQNode:
		var data: Dictionary
		var priority: int
		var next: Dictionary
		
		func _init(data, target):
			self.data = data
			self.priority = Constants.heuristic(self.data, target)

class PriorityQueue:
	var head = null
	var target: Dictionary
	var distance: int
	
	func _init(target):
		self.target = target
	
	func enqueue(data):
		var new_node = PQNode.new(data, self.target)
		if(self.head == null):
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
	
	
