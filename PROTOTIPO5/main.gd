extends Node2D

@onready var spawner: Node2D = $Spawner
@onready var notas_contenedor: Node = $Notas
@onready var linea: Node2D = $Linea
@onready var musica: AudioStreamPlayer2D = $Musica  # 🎵 Agregá tu nodo de música
@onready var tambor: AudioStreamPlayer2D = $Tambor

var secuencia_data: Secuencia = preload("res://PROTOTIPO5/secuencia.gd").new()
var nota_scene: PackedScene = preload("res://PROTOTIPO5/Nota.tscn")

var index_nota: int = 0
var velocidad: float = 200.0
var HIT_WINDOW: float = 60.0  # tolerancia vertical en píxeles

func _ready() -> void:
	if not InputMap.has_action("subir_pitch"):
		InputMap.add_action("subir_pitch")
		var ev_up = InputEventKey.new()
		ev_up.keycode = KEY_UP
		InputMap.action_add_event("subir_pitch", ev_up)
	
	
	
	# Acción "hit" (barra espaciadora)
	if not InputMap.has_action("hit"):
		InputMap.add_action("hit")
		var ev: InputEventKey = InputEventKey.new()
		ev.keycode = KEY_SPACE
		InputMap.action_add_event("hit", ev)

	print("Secuencia cargada: ", secuencia_data.data.size(), " notas.")
	musica.play()  # Empieza la canción

func _process(delta: float) -> void:
	if Input.is_action_pressed("subir_pitch"):
		tambor.pitch_scale += 7  # ajustá el valor según lo rápido que quieras
	
	
	var tiempo_actual: float = musica.get_playback_position()  # ⏱ Tiempo exacto del MP3

	# Spawnear notas cuando corresponde
	while index_nota < secuencia_data.data.size() and tiempo_actual >= secuencia_data.data[index_nota]["tiempo"]:
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
				print("ACIERTO! dy=", dy)
				nota.queue_free()
				$Tambor.play()  # suena tambor
				acierto = true
				break
		if not acierto:
			print("FALLO")

func spawn_nota(tecla: String) -> void:
	var n: Node2D = nota_scene.instantiate()
	n.position = spawner.position
	n.set("tecla", tecla)
	notas_contenedor.add_child(n)


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://menuInicio/inicio.tscn")
