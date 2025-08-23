extends Control

@onready var titulo: Sprite2D = $titulo

func _ready() -> void:
	_iniciar_metronomo(titulo)

func _iniciar_metronomo(sprite: Sprite2D) -> void:
	var tween = create_tween()
	tween.set_loops()  # repetir infinitamente
	# Escala a 0.115 en 0.5s
	tween.tween_property(sprite, "scale", Vector2(0.115, 0.115), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Luego vuelve a 0.1 en 0.5s
	tween.tween_property(sprite, "scale", Vector2(0.1, 0.1), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
























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


func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://historia/historia1.tscn")


func _on_button_6_pressed() -> void:
	get_tree().change_scene_to_file("res://creditos/creditos.tscn")
