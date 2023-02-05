extends Node2D

onready var tolerance_value

func _process(_delta):
	$Label.text = "Tolerance: " + str($HSlider.value) + "%"
	tolerance_value = $HSlider.value
