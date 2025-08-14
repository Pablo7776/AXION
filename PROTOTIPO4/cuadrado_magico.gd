extends Node2D

@export var speed_degrees: float = 45.0  # grados por segundo

func _process(delta):
	rotation_degrees += speed_degrees * delta
