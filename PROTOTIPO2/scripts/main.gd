extends Node2D

@onready var spawner = $Spawner
@onready var timer = $Timer
@onready var bolitas_contenedor = $Bolitas
@onready var musica = $Musica
@onready var linea = $Linea

var bolita_scene := preload("res://PROTOTIPO2/escenas/Bolita.tscn")
var bolitas_en_linea := []

func _ready():
	# conectar señales
	timer.timeout.connect(Callable(self, "_on_timer_timeout"))
	linea.area_entered.connect(Callable(self, "_on_linea_area_entered"))
	linea.area_exited.connect(Callable(self, "_on_linea_area_exited"))

	# arrancar spawner y música (si hay)
	timer.start()
	if musica.stream:
		musica.play()

func _on_timer_timeout():
	var bolita = bolita_scene.instantiate()
	# usar posición global del spawner para que coincida con la cámara/escala
	bolita.global_position = spawner.global_position
	bolitas_contenedor.add_child(bolita)

func _on_linea_area_entered(area):
	# area es el Area2D que entró en la línea (esperamos que sea una 'bolita')
	if area.is_in_group("bolita"):
		# prevenir duplicados
		if not (area in bolitas_en_linea):
			bolitas_en_linea.append(area)

func _on_linea_area_exited(area):
	if area in bolitas_en_linea:
		bolitas_en_linea.erase(area)

func _input(event):
	if event.is_action_pressed("hit"):
		if bolitas_en_linea.size() > 0:
			# acierta la primera (podés afinar la lógica: el más cercano, el más nuevo, etc.)
			var target = bolitas_en_linea[0]
			target.queue_free()
			bolitas_en_linea.erase(target)
			print("¡ACIERTAS!")
		else:
			print("MISS")
