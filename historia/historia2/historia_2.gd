extends Control
@onready var audio = $AudioStreamPlayer

func _on_button_pressed() -> void:
	if audio.playing:
		audio.stop()
	else:
		audio.play()


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://PROTOTIPO5/Main.tscn")
