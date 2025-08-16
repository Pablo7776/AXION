
extends Node2D

@onready var spawner: Node2D = $Spawner
@onready var notas_contenedor: Node = $Notas
@onready var linea: Node2D = $Linea
@onready var musica: AudioStreamPlayer2D = $Musica
@onready var tambor: AudioStreamPlayer2D = $Tambor

@onready var label_aciertos: Label = $LabelAciertos
@onready var label_pifies: Label = $LabelPifies

var secuencia_data: Secuencia = preload("res://PROTOTIPO5/secuencia.gd").new()
var nota_scene: PackedScene = preload("res://PROTOTIPO5/Nota.tscn")

var index_nota: int = 0
var velocidad: float = 400.0
var HIT_WINDOW: float = 100.0

var aciertos: int = 0
var pifies: int = 0
var lead_time: float = 0.0  # ⏱ tiempo de anticipación

func _ready() -> void:
	# Calcular anticipación para que la nota llegue a la línea a tiempo
	var distancia: float = linea.global_position.y - spawner.global_position.y
	lead_time = distancia / velocidad

	print("Secuencia cargada: ", secuencia_data.data.size(), " notas.")
	musica.play()

func _process(delta: float) -> void:
	if Input.is_action_pressed("subir_pitch"):
		tambor.pitch_scale += 7

	var tiempo_actual: float = musica.get_playback_position()

	# Spawnear notas con anticipación
	while index_nota < secuencia_data.data.size() and tiempo_actual >= secuencia_data.data[index_nota]["tiempo"] - lead_time:
		spawn_nota(secuencia_data.data[index_nota]["tecla"])
		index_nota += 1

	# Mover notas
	for nota in notas_contenedor.get_children():
		(nota as Node2D).position.y += velocidad * delta
		if (nota as Node2D).position.y > 1200.0:
			nota.queue_free()

	# Detectar input
	if Input.is_action_just_pressed("hit"):
		var acierto: bool = false
		for nota in notas_contenedor.get_children():
			var dy: float = abs((nota as Node2D).global_position.y - linea.global_position.y)
			if dy <= HIT_WINDOW:
				aciertos += 1
				print("ACIERTO! dy=", dy)
				nota.queue_free()
				tambor.play()
				acierto = true
				break
		if not acierto:
			pifies += 1
			print("FALLO")
		label_aciertos.text = "Aciertos: %d" % aciertos
		label_pifies.text = "Pifies: %d" % pifies

func spawn_nota(tecla: String) -> void:
	var n: Node2D = nota_scene.instantiate()
	n.global_position = spawner.global_position  # POSICIÓN EXACTA DEL SPWANER
	n.set("tecla", tecla)
	notas_contenedor.add_child(n)

func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://menuInicio/inicio.tscn")
