extends Node2D

var vertical_line = preload("res://VerticalLine.tscn")
var horizontal_line = preload("res://HorizontalLine.tscn")
onready var line_position_x = 64
onready var line_position_y = 64
onready var amount_lines = 10
onready var screensize_x
onready var screensize_y

func _ready():
	pass

func _process(_delta):
	screensize_x = get_viewport().size.x
	screensize_y = get_viewport().size.y
	if line_position_x < screensize_x:
		spawn_vertical_line()
	if line_position_y < screensize_y:
		spawn_horizontal_line()

func spawn_vertical_line():
	var vertical_line_instance = vertical_line.instance()
	add_child(vertical_line_instance)
	vertical_line_instance.position.x = line_position_x
	line_position_x = line_position_x + (screensize_x/amount_lines)

func spawn_horizontal_line():
	var horizontal_line_instance = horizontal_line.instance()
	add_child(horizontal_line_instance)
	horizontal_line_instance.position.y = line_position_y
	line_position_y = line_position_y + (screensize_y/amount_lines)
