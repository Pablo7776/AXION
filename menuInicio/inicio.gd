extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/ejemploBasico.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://PROTOTIPO2/escenas/main.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://PROTOTIPO3/escenas/main.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://PROTOTIPO5/Main.tscn")
