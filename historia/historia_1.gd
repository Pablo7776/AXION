extends Control

@onready var audio = $audio

func _on_button_pressed():
	if audio.playing:
		audio.stop()
	else:
		audio.play()


func _on_siguiente_pressed() -> void:
	get_tree().change_scene_to_file("res://historia/historia2/historia2.tscn")
