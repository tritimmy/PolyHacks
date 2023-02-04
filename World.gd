extends Node2D

var map_meeple = []
var angry_meeple_list = []
var empty_spots_index = []

func _ready():
	randomize()

func teleport_meeples():
	for index in range(len(map_meeple)):
		if map_meeple[index] == 0:
			empty_spots_index.append(index)

	for start_position in angry_meeple_list:
		var random_empty_spot = randi() % len(empty_spots_index)
		var end_position = empty_spots_index[random_empty_spot]
		map_meeple[end_position] = map_meeple[start_position]
		map_meeple[start_position] = 0
		empty_spots_index.append(start_position)
		empty_spots_index.remove(end_position)
		
	angry_meeple_list.clear()
