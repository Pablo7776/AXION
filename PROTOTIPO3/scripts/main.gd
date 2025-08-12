extends Node2D

@onready var spawners = [
	$SpawnerNorte,
	$SpawnerSur,
	$SpawnerEste,
	$SpawnerOeste
]
@onready var musica = $Musica
@onready var timer = $Timer
@onready var bolitas_contenedor = $Bolitas
var bolita_scene := preload("res://PROTOTIPO2/escenas/Bolita.tscn")

func _ready():
	timer.timeout.connect(Callable(self, "_on_timer_timeout"))
	timer.start()  # ajustá el tiempo para que coincida con el ritmo de la música
	if musica.stream:
		musica.play()
func _on_timer_timeout():
	for spawner in spawners:
		var bolita = bolita_scene.instantiate()
		bolita.global_position = spawner.global_position
		bolita.rotation = spawner.rotation  # le pasamos el ángulo para que la bolita salga en esa dirección
		bolitas_contenedor.add_child(bolita)
