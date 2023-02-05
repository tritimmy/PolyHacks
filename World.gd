extends Node2D

var width = 10
var height = width 
var number_of_spots = width * height
var map = []
var angry_meeple_list = []
var empty_spots_index = []
var number_of_colors = 2
var ratio_empty_spots = 0.2
var acceptance_ratio = 0.5
var ratio_of_meeple = [0.4, 0.4, 0, 0, 0, 0, 0, 0]

onready var meeple_position_x = 32
onready var meeple_position_y = 32
var meeple = preload("res://Meeple.tscn")


func _ready():
	randomize()
	initialize()
	meeple_generator()
	simulation()

func set_number_of_colors(new_number):
	number_of_colors = new_number
	
func set_ration_empty_spots(new_ratio):
	ratio_empty_spots = new_ratio
	
func set_acceptance_ratio(new_ratio):
	acceptance_ratio = new_ratio
	
func simulation():
	var end = true
	for i in range (len(map)):
		var number_of_adjacent_meeple = 0
		var number_of_similar_meeple = 0
		if map[i] != 0:
			var meeple_color = map[i]
			var left = i % width == 0 
			var right = i % width == width-1
			var up = i < width
			var down = i > width*(height-1)-1
			
			if !left:
				if map[i-1] != 0 :
					number_of_adjacent_meeple += 1
					if map[i-1] == meeple_color:
						number_of_similar_meeple += 1
				if !up:
					if map[i-1-width] != 0 :
						number_of_adjacent_meeple += 1
						if map[i-1-width] == meeple_color:
							number_of_similar_meeple +=1
				if !down:
					if map[i-1+width] != 0 :
						number_of_adjacent_meeple += 1
						if map[i-1+width] == meeple_color:
							number_of_similar_meeple +=1
						
			if !right:
				if map[i+1] != 0:
					number_of_adjacent_meeple += 1
					if map[i+1] == meeple_color:
						number_of_similar_meeple += 1
				if !up:
					if map[i+1-width] != 0:
						number_of_adjacent_meeple += 1
						if map[i+1-width] == meeple_color:
							number_of_similar_meeple +=1
				if !down:
					if map[i+1+width] != 0:
						number_of_adjacent_meeple += 1
						if map[i+1+width] == meeple_color:
							number_of_similar_meeple +=1
						
			if !up:
				if map[i-width] != 0:
					number_of_adjacent_meeple += 1
					if map[i-width] == meeple_color:
						number_of_similar_meeple +=1
					
			if !down:
				if map[i+width] != 0:
					number_of_adjacent_meeple += 1
					if map[i+width] == meeple_color:
						number_of_similar_meeple += 1
				
		if number_of_adjacent_meeple != 0 and (number_of_similar_meeple/number_of_adjacent_meeple) < acceptance_ratio:
			end = false
			print(number_of_adjacent_meeple)
			angry_meeple_list.append(i)
			
			
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
	print(map)

func meeple_generator():
	for i in range(len(map)):
		var right = i % width == width-1
		var meeple_color = map[i]
		if meeple_color == 1:
			spawn_meeple()
		elif meeple_color == 2:
			spawn_meeple2()
		elif meeple_color == 3:
			spawn_meeple()
		elif meeple_color == 4:
			spawn_meeple()
		elif meeple_color == 5:
			spawn_meeple()
		elif meeple_color == 6:
			spawn_meeple()
		elif meeple_color == 7:
			spawn_meeple()
		elif meeple_color == 8:
			spawn_meeple()
			
		if right: 
			meeple_position_x = 32
			meeple_position_y += 64
		else:
			meeple_position_x += 64
		

func spawn_meeple():
	var meeple_instance = meeple.instance()
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y

func spawn_meeple2():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(0,255,255)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
