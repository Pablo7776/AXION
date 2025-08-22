extends Node2D

@onready var spawner: Node2D = $Spawner
@onready var spawner2: Node2D = $Spawner2
@onready var spawner3: Node2D = $Spawner3
@onready var spawner4: Node2D = $Spawner4
@onready var notas_contenedor: Node = $Notas
@onready var notas_contenedor2: Node = $Notas2
@onready var notas_contenedor3: Node = $Notas3
@onready var notas_contenedor4: Node = $Notas4
@onready var linea: Node2D = $Linea
@onready var musica: AudioStreamPlayer2D = $Musica
@onready var sonidoDerecha: AudioStreamPlayer2D = $sonidoDerecha
@onready var sonidoIzquierda: AudioStreamPlayer2D = $sonidoIzquierda
@onready var sonidoArriba: AudioStreamPlayer2D = $sonidoArriba
@onready var sonidoAbajo: AudioStreamPlayer2D = $sonidoAbajo

@onready var label_aciertos: Label = $LabelAciertos
@onready var label_pifies: Label = $LabelPifies

var secuencia_data: SecuenciaDerecha = preload("res://PROTOTIPO5/secuenciaDerecha.gd").new()
var secuencia_data2: SecuenciaIzquierda = preload("res://PROTOTIPO5/secuenciaIzquierda.gd").new()
var secuencia_data3: SecuenciaArriba = preload("res://PROTOTIPO5/secuenciaArriba.gd").new()
var secuencia_data4: SecuenciaAbajo = preload("res://PROTOTIPO5/secuenciaAbajo.gd").new()

var nota_scene: PackedScene = preload("res://PROTOTIPO5/NotaDerecha.tscn")
var nota_scene2: PackedScene = preload("res://PROTOTIPO5/NotaIzquierda.tscn")
var nota_scene3: PackedScene = preload("res://PROTOTIPO5/NotaArriba.tscn")
var nota_scene4: PackedScene = preload("res://PROTOTIPO5/NotaAbajo.tscn")

var index_nota: int = 0
var index_nota2: int = 0
var index_nota3: int = 0
var index_nota4: int = 0
var velocidad: float = 400.0
var HIT_WINDOW: float = 100.0

var aciertos: int = 0
var pifies: int = 0
var lead_time: float = 0.0  # tiempo de anticipación

func _ready() -> void:
	var distancia: float = linea.global_position.y - spawner.global_position.y
	lead_time = distancia / velocidad

	print("Secuencias cargadas:", 
		secuencia_data.data.size(), 
		secuencia_data2.data.size(), 
		secuencia_data3.data.size(),
		secuencia_data4.data.size())
	musica.play()

func _process(delta: float) -> void:
	var tiempo_actual: float = musica.get_playback_position()

	# Spawner 1
	while index_nota < secuencia_data.data.size() and tiempo_actual >= secuencia_data.data[index_nota]["tiempo"] - lead_time:
		spawn_nota(secuencia_data.data[index_nota]["tecla"])
		index_nota += 1

	# Spawner 2
	while index_nota2 < secuencia_data2.data.size() and tiempo_actual >= secuencia_data2.data[index_nota2]["tiempo"] - lead_time:
		spawn_nota2(secuencia_data2.data[index_nota2]["tecla"])
		index_nota2 += 1

	# Spawner 3
	while index_nota3 < secuencia_data3.data.size() and tiempo_actual >= secuencia_data3.data[index_nota3]["tiempo"] - lead_time:
		spawn_nota3(secuencia_data3.data[index_nota3]["tecla"])
		index_nota3 += 1

	# Spawner 4
	while index_nota4 < secuencia_data4.data.size() and tiempo_actual >= secuencia_data4.data[index_nota4]["tiempo"] - lead_time:
		spawn_nota4(secuencia_data4.data[index_nota4]["tecla"])
		index_nota4 += 1
	# Mover notas
	_mover_notas(notas_contenedor, delta)
	_mover_notas(notas_contenedor2, delta)
	_mover_notas(notas_contenedor3, delta)
	_mover_notas(notas_contenedor4, delta)

	# Inputs
	if Input.is_action_just_pressed("hitDerecha"):
		_revisar_acierto(notas_contenedor, "ACIERTO 1", "FALLO 1", sonidoDerecha)

	if Input.is_action_just_pressed("hitIzquierda"):
		_revisar_acierto(notas_contenedor2, "ACIERTO 2", "FALLO 2", sonidoIzquierda)

	if Input.is_action_just_pressed("hitArriba"):
		_revisar_acierto(notas_contenedor3, "ACIERTO 3", "FALLO 3", sonidoArriba)

	if Input.is_action_just_pressed("hitAbajo"):
		_revisar_acierto(notas_contenedor4, "ACIERTO 4", "FALLO 4", sonidoAbajo)

	# Fin del juego
	if not musica.playing \
	and index_nota >= secuencia_data.data.size() \
	and index_nota2 >= secuencia_data2.data.size() \
	and index_nota3 >= secuencia_data3.data.size() \
	and index_nota4 >= secuencia_data4.data.size() \
	and notas_contenedor.get_child_count() == 0 \
	and notas_contenedor2.get_child_count() == 0 \
	and notas_contenedor3.get_child_count() == 0 \
	and notas_contenedor4.get_child_count() == 0:
		finalizar_juego()

func _mover_notas(contenedor: Node, delta: float) -> void:
	for nota in contenedor.get_children():
		(nota as Node2D).position.y += velocidad * delta
		if (nota as Node2D).position.y > 1200.0:
			nota.queue_free()

func _revisar_acierto(contenedor: Node, msg_ok: String, msg_fail: String, sonido: AudioStreamPlayer2D) -> void:
	var acierto: bool = false
	for nota in contenedor.get_children():
		var dy: float = abs((nota as Node2D).global_position.y - linea.global_position.y)
		if dy <= HIT_WINDOW:
			aciertos += 1
			print(msg_ok, "dy=", dy)
			nota.queue_free()
			sonido.play()
			acierto = true
			break
	if not acierto:
		pifies += 1
		print(msg_fail)

	label_aciertos.text = "Aciertos: %d" % aciertos
	label_pifies.text = "Pifies: %d" % pifies

func spawn_nota(tecla: String) -> void:
	var n: Node2D = nota_scene.instantiate()
	n.global_position = spawner.global_position
	n.set("tecla", tecla)
	notas_contenedor.add_child(n)

func spawn_nota2(tecla: String) -> void:
	var n: Node2D = nota_scene2.instantiate()
	n.global_position = spawner2.global_position
	n.set("tecla", tecla)
	notas_contenedor2.add_child(n)

func spawn_nota3(tecla: String) -> void:
	var n: Node2D = nota_scene3.instantiate()
	n.global_position = spawner3.global_position
	n.set("tecla", tecla)
	notas_contenedor3.add_child(n)
	
func spawn_nota4(tecla: String) -> void:
	var n: Node2D = nota_scene4.instantiate()
	n.global_position = spawner4.global_position
	n.set("tecla", tecla)
	notas_contenedor4.add_child(n)

func finalizar_juego() -> void:
	var total_notas: int = (
		secuencia_data.data.size() +
		secuencia_data2.data.size() +
		secuencia_data3.data.size() +
		secuencia_data4.data.size()
	)
	var porcentaje: float = 0.0
	if total_notas > 0:
		porcentaje = float(aciertos) / total_notas * 100.0

	if porcentaje >= 90.0:
		Juego.resultado = "¡Excelente!"
	elif porcentaje >= 50.0:
		Juego.resultado = "Bien"
	else:
		Juego.resultado = "Seguí practicando"

	get_tree().change_scene_to_file("res://PROTOTIPO5/Resultado.tscn")

func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://menuInicio/inicio.tscn")
