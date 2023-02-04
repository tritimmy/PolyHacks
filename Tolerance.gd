extends Node2D

func _process(delta):
	$Label.text = "Tolerance: " + str($HSlider.value) + "%"
