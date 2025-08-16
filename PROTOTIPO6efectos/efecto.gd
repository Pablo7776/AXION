extends Node2D

@onready var musica: AudioStreamPlayer = $AudioStreamPlayer
@onready var sprite: TextureRect = $Sprite2D

# Configuración del beat
var bpm: float = 120.0          # Cambiá esto por el BPM de tu canción
var duracion_beat: float = 0.0
var tiempo_acumulado: float = 0.0

func _ready() -> void:
	# Calculamos duración de cada beat en segundos
	duracion_beat = 60.0 / bpm
	# Empezamos la canción
	musica.play()

func _process(delta: float) -> void:
	if not musica.playing:
		return

	# Sumamos tiempo transcurrido
	tiempo_acumulado += delta

	# Si pasó un beat, disparar efecto
	while tiempo_acumulado >= duracion_beat:
		disparar_efecto()
		tiempo_acumulado -= duracion_beat

func disparar_efecto() -> void:
	# Cambia a un color aleatorio
	sprite.modulate = Color(randf(), 0, 0)
