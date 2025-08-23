extends Control

@onready var label_resultado: Label = $LabelResultado
@onready var boton_volver: Button = $BotonVolver

#var mensaje: String = ""  # Este texto lo recibimos desde main
@onready var historial_label = $RichTextLabel

func _ready() -> void:
	#label_resultado.text = Juego.resultado
	historial_label.clear()
	var index = 1
	for partida in Juego.historial:
		historial_label.add_text("Práctica %d -> Aciertos: %d | Pifies: %d\n" % [
			index, partida.aciertos, partida.pifies
	])
		index += 1

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menuInicio/inicio.tscn")
