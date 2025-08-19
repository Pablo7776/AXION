extends Control

@onready var label_resultado: Label = $LabelResultado
@onready var boton_volver: Button = $BotonVolver

#var mensaje: String = ""  # Este texto lo recibimos desde main

func _ready() -> void:
	label_resultado.text = Juego.resultado


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menuInicio/inicio.tscn")
