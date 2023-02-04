extends Node2D

onready var tolerance_value = $HSlider.value

func _process(_delta):
	$Label.text = "Tolerance: " + str(tolerance_value) + "%"
