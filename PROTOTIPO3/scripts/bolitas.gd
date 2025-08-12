extends Area2D

@export var speed: float = 500.0

func _ready():
	add_to_group("bolita")

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

	# Borrar si sale mucho de pantalla (podés ajustar valores según tu escena)
	if abs(position.x) > 3000 or abs(position.y) > 3000:
		queue_free()
