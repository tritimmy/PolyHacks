extends Area2D

onready var ray = $RayCast2D
onready var sprite = $Sprite

var tile_size = 64
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

var mood = "happy"

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func move(dir):
	position += inputs[dir] * tile_size

func change_sprite(color, state):
	sprite.set_frame(2 * color + state)

func change_size(new_size):
	tile_size = new_size

func _on_Meeple_input_event(_viewport, _event, _shape_idx):
	pass
	
func set_meeple_mood(_mood):
	if _mood == "happy":
		mood = "happy"
		sprite.set_frame(1)
	if mood == "angry":
		mood = "angry"
		sprite.set_frame(0)

func kill():
	queue_free()
