extends Node2D

var width = 20
var height = width 
var number_of_spots = width * height
var map = []
var angry_meeple_list = []
var empty_spots_index = []
var number_of_colors = 2
var ratio_empty_spots = 0.2
var acceptance_ratio = 0.5
var ratio_of_meeple = [0.4, 0.4, 0, 0, 0, 0, 0, 0]


func _ready():
	randomize()
	initialize()

func set_number_of_colors(new_number):
	number_of_colors = new_number
	
func set_ration_empty_spots(new_ratio):
	ratio_empty_spots = new_ratio
	
func set_acceptance_ratio(new_ratio):
	acceptance_ratio = new_ratio
	
func simulation():
	var end = true
	for i in range (len(map)):
		var number_of_meeple
		var number_of_similar_meeple
		if map[i] != 0:
			var meeple_color = map[i]
			var left = i % width == 0 
			var right = i % width == width-1
			var up = i < width
			var down = i > width*(height-1)-1
			
			if !left:
				pass
		#if(number_of_similar_meeple/number_of_meeple) < acceptance_ratio:
			
			
	if end == false:
		teleport_meeples()
		

func teleport_meeples():
	for index in range(len(map)):
		if map[index] == 0:
			empty_spots_index.append(index)

	for start_position in angry_meeple_list:
		var random_empty_spot = randi() % len(empty_spots_index)
		var end_position = empty_spots_index[random_empty_spot]
		map[end_position] = map[start_position]
		map[start_position] = 0
		empty_spots_index.append(start_position)
		empty_spots_index.remove(end_position)
		
	angry_meeple_list.clear()
	
	
func initialize():
	for i in range(number_of_spots):
		map.append(0)
	for j in range(len(ratio_of_meeple)):
		if(ratio_of_meeple[j] !=  0):
			var number_of_specific_meeple = floor(ratio_of_meeple[j] * number_of_spots)
			for k in range(number_of_specific_meeple):
				var new_position = randi() % number_of_spots
				while map[new_position] != 0:
					new_position = randi() % number_of_spots
				map[new_position] = j+1

