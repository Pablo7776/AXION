extends Control

@onready var audio_do = $AudioStreamPlayer
@onready var audio_re = $AudioStreamPlayer2
@onready var audio_mi = $AudioStreamPlayer3

var r = 1.0
var g = 0.4
var b = 0.1

var r2 = 1.0
var g2 = 0.0
var b2 = 0.0

var r3 = 1.0
var g3 = 0.0
var b3 = 0.0

var poly1
var poly2
var poly3

var tiempo = 0.0

func _ready():
	poly1 = $ColorRect2/Polygon2D
	poly2 = $ColorRect2/Polygon2D2
	poly3 = $ColorRect2/Polygon2D3

	# Color inicial
	poly1.color = Color(r, g, b)
	poly2.color = Color(r2, g2, b2)
	poly3.color = Color(r3, g3, b3)

func _process(delta):
	tiempo += delta
	r = (sin(tiempo) + 1) / 2
	r2 = (sin(tiempo * 0.8 + 1) + 1) / 2
	r3 = (sin(tiempo * 1.2 + 2) + 1) / 2

	poly1.color = Color(r, g, b)
	poly2.color = Color(r2, g2, b2)
	poly3.color = Color(r3, g3, b3)

func _on_button_pressed() -> void:
	audio_do.play()

func _on_button_2_pressed() -> void:
	audio_re.play()

func _on_button_3_pressed() -> void:
	audio_mi.play()
