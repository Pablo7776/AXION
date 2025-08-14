extends Node2D


func _process(delta):
	# Rotar una vuelta completa cada segundo
	rotation_degrees += 90 * delta
