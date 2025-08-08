extends Control


@onready var audio_do = $AudioStreamPlayer
@onready var audio_re = $AudioStreamPlayer2
@onready var audio_mi = $AudioStreamPlayer3

func _on_button_pressed() -> void:
	audio_do.play()


func _on_button_2_pressed() -> void:
	audio_re.play()


func _on_button_3_pressed() -> void:
	audio_mi.play()
