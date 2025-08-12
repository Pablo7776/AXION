extends Area2D

@export var speed: float = 500.0

func _ready():
	add_to_group("bolita")  # para identificarla luego

func _process(delta):
	position.y += speed * delta
	if position.y > 2000:  # elimínala si baja mucho
		queue_free()
