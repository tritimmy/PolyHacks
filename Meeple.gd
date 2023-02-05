extends Area2D

onready var ray = $RayCast2D
onready var sprite = $Sprite

var tile_size = 64

var mood = "happy"

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)

func change_sprite(color, state):
	sprite.set_frame(2 * color + state)

func change_size(new_size):
	tile_size = new_size
	
func set_meeple_mood(_mood):
	if _mood == "happy":
		mood = "happy"
		sprite.set_frame(0)
	else:
		mood = "angry"
		sprite.set_frame(1)
