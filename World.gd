extends Node2D

var width = 10
var height = width 
var number_of_spots = width * height
var map = []
var wr_list = []
var object_meeple = []
var angry_meeple_list = []
var empty_spots_index = []
var number_of_colors = 2
var ratio_empty_spots = 0.2
var acceptance_ratio = 50
var ratio_of_meeple = [0.4, 0.4, 0, 0, 0, 0, 0, 0]

onready var meeple_position_x = 32
onready var meeple_position_y = 32
var meeple = preload("res://Meeple.tscn")

onready var teleporting_meeples = false

func _ready():
	randomize()
	set_tolerance(acceptance_ratio)
	initialize()
	meeple_generator()
	

func set_number_of_colors(new_number):
	number_of_colors = new_number
	
func set_ration_empty_spots(new_ratio):
	ratio_empty_spots = new_ratio
	
func set_acceptance_ratio(new_ratio):
	acceptance_ratio = new_ratio
	
func simulation():
	var end = true
	teleporting_meeples = false
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
				
			number_of_adjacent_meeple = float(number_of_adjacent_meeple)
			number_of_similar_meeple = float(number_of_similar_meeple)
			if number_of_adjacent_meeple != 0 and (number_of_similar_meeple/number_of_adjacent_meeple) < (1.0-acceptance_ratio):
				end = false
				angry_meeple_list.append(i)
			else:
				if object_meeple[i] != null:
					object_meeple[i].set_meeple_mood("happy")
			
	if end == false:
		print(angry_meeple_list)
		teleporting_meeples = true
		
		

func teleport_meeples():
	for index in range(len(map)):
		if map[index] == 0:
			empty_spots_index.append(index)

	for i in range (len(angry_meeple_list)):
		var random_empty_spot = randi() % len(empty_spots_index)
		var end_position = empty_spots_index[random_empty_spot]
		var start_position = angry_meeple_list[i]
		map[end_position] = map[start_position]
		map[start_position] = 0
		empty_spots_index.append(start_position)
		#print(empty_spots_index)
		empty_spots_index.remove(empty_spots_index.find(end_position))
		#print(empty_spots_index)
	
	empty_spots_index.clear()
	angry_meeple_list.clear()
	for wr in wr_list:
		var obj = wr.get_ref()
		if (obj):
			obj.free()
	meeple_generator()
	simulation()
	
	
func initialize():
	for _i in range(number_of_spots): # Resize
		map.append(0)
	for _j in range(len(ratio_of_meeple)):
		if(ratio_of_meeple[_j] !=  0):
			var number_of_specific_meeple = floor(ratio_of_meeple[_j] * number_of_spots)
			for _k in range(number_of_specific_meeple):
				var new_position = randi() % number_of_spots
				while map[new_position] != 0:
					new_position = randi() % number_of_spots
				map[new_position] = _j+1


func meeple_generator():
	meeple_position_y = 640/height/2
	object_meeple.clear()
	for i in range(len(map)):
		var right = (i % width == width-1)
		var meeple_color = map[i]
		if meeple_color == 1:
			spawn_meeple()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 2:
			spawn_meeple2()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 3:
			spawn_meeple3()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 4:
			spawn_meeple4()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 5:
			spawn_meeple5()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 6:
			spawn_meeple6()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 7:
			spawn_meeple7()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 8:
			spawn_meeple8()
			object_meeple[i].set_meeple_mood("angry")
		elif meeple_color == 0:
			object_meeple.append(null)
			
		if right: 
			meeple_position_x = 320/width
			meeple_position_y += 640/height
		else:
			meeple_position_x += 640/width

func spawn_meeple():
	var meeple_instance = meeple.instance()

	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)

func spawn_meeple2():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(0,255,255)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)
	
func spawn_meeple3():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(255,0,255)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)
	
func spawn_meeple4():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(0,0,255)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)
	
func spawn_meeple5():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(225,0,0)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)
	
func spawn_meeple6():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(0,255,0)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)
	
func spawn_meeple7():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(225,255,255)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)
	
func spawn_meeple8():
	var meeple_instance = meeple.instance()
	meeple_instance.modulate = Color(0,0,0)
	add_child(meeple_instance)
	meeple_instance.position.x = meeple_position_x
	meeple_instance.position.y = meeple_position_y
	
	wr_list.append(weakref(meeple_instance))
	object_meeple.append(meeple_instance)

func _on_Timer_timeout():
	if teleporting_meeples == true:
		teleport_meeples()

func _process(_delta):
	set_tolerance($Tolerance/HSlider.value)
	set_colors($Colors/HSlider.value)

func set_tolerance(tolerance):
	$Tolerance/Label.text = "Tolerance: " + str(tolerance) + "%"
	$Tolerance/HSlider.value = tolerance
	acceptance_ratio = tolerance/100

func _on_Button_pressed():
	teleporting_meeples = true
	simulation()

func set_colors(colors):
	$Colors/Label.text = "Amount of Colors: " + str(colors)
	$Colors/HSlider.value = colors
	number_of_colors = colors
